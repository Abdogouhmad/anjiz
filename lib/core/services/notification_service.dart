import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/services/reminder_scheduler.dart';
import '../constants/app_constants.dart';
import '../utils/platform_support.dart';
import 'notification_channels.dart';
import 'notification_permissions.dart';
import 'notification_presenter.dart';

/// Thin wrapper over `flutter_local_notifications` that owns channel setup,
/// permission requests and timezone-aware scheduling.
///
/// The plugin is Android/iOS-only; on other platforms every method is a no-op.
class NotificationService implements ReminderScheduler {
  /// Creates a notification service.
  NotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  NotificationPresenter get _presenter => NotificationPresenter(_plugin);

  /// Initialises timezones, the plugin and Android channels (idempotent).
  Future<void> init() async {
    if (_initialized || !PlatformSupport.notifications) return;
    tz_data.initializeTimeZones();
    await _configureLocalTimezone();
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
    await createNotificationChannels(_android);
    _initialized = true;
  }

  Future<void> _configureLocalTimezone() async {
    try {
      final name = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(name));
    } on Object {
      // Fall back to the UTC default when the platform name is unavailable.
    }
  }

  AndroidFlutterLocalNotificationsPlugin? get _android {
    // On desktop and in unit tests the plugin's platform singleton is never
    // registered; touching it would throw a LateInitializationError.
    try {
      return _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
    } on Object {
      return null;
    }
  }

  /// Shows the "a newer version is available" notification.
  ///
  /// Silently does nothing without notification permission: the settings screen
  /// still reports the available update, so nothing is lost.
  Future<void> showUpdateAvailable({
    required String title,
    required String body,
  }) => _presenter.showUpdateAvailable(title: title, body: body);

  /// Checks whether notifications are enabled for the app.
  Future<bool> areNotificationsEnabled() async {
    final android = _android;
    if (android == null) return false;
    return android.isEnabled();
  }

  /// Requests notification permission, returning whether it was granted.
  @override
  Future<bool> requestPermission() async {
    final android = _android;
    if (android == null) return false;
    return android.requestNotifications();
  }

  /// Whether exact alarms (on-the-minute reminders) are currently allowed.
  Future<bool> canScheduleExactAlarms() async {
    final android = _android;
    if (android == null) return true;
    return android.allowsExactAlarms();
  }

  /// Asks Android for the exact-alarm permission (Android 12+), returning
  /// whether reminders may now fire at the precise minute.
  Future<bool> requestExactAlarmPermission() async {
    final android = _android;
    if (android == null) return true;
    return android.requestExactAlarms();
  }

  /// Shows an immediate test notification to verify delivery and sound/vibration.
  Future<void> showTestNotification({
    required String title,
    required String body,
  }) => _presenter.showTest(title: title, body: body);

  /// Schedules a one-off notification at [at], preferring exact delivery and
  /// degrading to inexact when the exact-alarm permission is missing.
  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    String channelId = AppConstants.reminderChannelId,
  }) async {
    if (!PlatformSupport.notifications) return;
    final scheduled = tz.TZDateTime.from(at, tz.local);
    if (!scheduled.isAfter(tz.TZDateTime.now(tz.local))) return;
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      _details(channelId, Importance.high),
      androidScheduleMode: await _scheduleMode(),
      payload: title,
    );
  }

  /// Schedules a repeating daily notification at [hour]:[minute] local time.
  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    int hour = AppConstants.dailyBriefingHour,
    int minute = 0,
  }) async {
    if (!PlatformSupport.notifications) return;
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      _nextDailyRun(hour, minute),
      _details(AppConstants.briefingChannelId, Importance.defaultImportance),
      androidScheduleMode: await _scheduleMode(),
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Cancels a pending notification.
  @override
  Future<void> cancel(int id) async {
    if (!PlatformSupport.notifications) return;
    await _plugin.cancel(id);
  }

  /// Cancels every pending notification.
  Future<void> cancelAll() async {
    if (!PlatformSupport.notifications) return;
    await _plugin.cancelAll();
  }

  Future<AndroidScheduleMode> _scheduleMode() async {
    final allowed = await canScheduleExactAlarms();
    return allowed
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
  }

  static const String _snoozeActionId = 'snooze_10min';

  /// Reschedules a reminder 10 minutes later when its snooze action is tapped.
  ///
  /// The notification is re-posted under the same id so repeated snoozes keep
  /// stacking on the original reminder.
  Future<void> _onNotificationResponse(NotificationResponse response) async {
    if (!PlatformSupport.notifications) return;
    if (response.actionId != _snoozeActionId) return;
    final id = response.id;
    if (id == null) return;
    final at = tz.TZDateTime.now(tz.local).add(_snoozeDelay);
    if (!_initialized) {
      tz_data.initializeTimeZones();
      await _configureLocalTimezone();
    }
    await _plugin.zonedSchedule(
      id,
      response.payload ?? 'Reminder',
      'Snoozed for 10 minutes',
      at,
      _details(AppConstants.reminderChannelId, Importance.high),
      androidScheduleMode: await _scheduleMode(),
    );
  }

  static const Duration _snoozeDelay = Duration(minutes: 10);

  tz.TZDateTime _nextDailyRun(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var next = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (!next.isAfter(now)) next = next.add(const Duration(days: 1));
    return next;
  }

  NotificationDetails _details(String channelId, Importance importance) =>
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          'Anjiz',
          importance: importance,
          priority: importance == Importance.high
              ? Priority.high
              : Priority.defaultPriority,
          actions: channelId == AppConstants.reminderChannelId
              ? <AndroidNotificationAction>[
                  const AndroidNotificationAction(
                    _snoozeActionId,
                    'Snooze 10 min',
                    showsUserInterface: true,
                    allowGeneratedReplies: false,
                  ),
                ]
              : null,
        ),
      );
}

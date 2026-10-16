import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/services/reminder_scheduler.dart';
import '../constants/app_constants.dart';
import '../utils/platform_support.dart';

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

  /// Initialises timezones, the plugin and Android channels (idempotent).
  Future<void> init() async {
    if (_initialized || !PlatformSupport.notifications) return;
    tz_data.initializeTimeZones();
    await _configureLocalTimezone();
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(settings);
    await _createChannels();
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

  Future<void> _createChannels() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        AppConstants.reminderChannelId,
        'Task reminders',
        description: 'Reminders for tasks with a due time.',
        importance: Importance.high,
      ),
    );
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        AppConstants.briefingChannelId,
        'Daily briefing',
        description: 'A morning summary of prioritised tasks.',
        importance: Importance.defaultImportance,
      ),
    );
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        AppConstants.updatesChannelId,
        'App updates',
        description: 'Tells you when a newer version of Anjiz is available.',
        importance: Importance.low,
      ),
    );
  }

  /// Shows the "a newer version is available" notification.
  ///
  /// Silently does nothing without notification permission: the settings screen
  /// still reports the available update, so nothing is lost.
  Future<void> showUpdateAvailable({
    required String title,
    required String body,
  }) async {
    if (!PlatformSupport.notifications) return;
    await _plugin.show(
      AppConstants.updateNotificationId,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          AppConstants.updatesChannelId,
          'App updates',
          importance: Importance.low,
          priority: Priority.low,
        ),
      ),
    );
  }

  /// Checks whether notifications are enabled for the app.
  Future<bool> areNotificationsEnabled() async {
    if (!PlatformSupport.notifications) return false;
    try {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final enabled = await android?.areNotificationsEnabled();
      return enabled ?? false;
    } on Object {
      return false;
    }
  }

  /// Requests notification permission, returning whether it was granted.
  @override
  Future<bool> requestPermission() async {
    if (!PlatformSupport.notifications) return false;
    try {
      final android = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final granted = await android?.requestNotificationsPermission();
      return granted ?? false;
    } on Object {
      return false;
    }
  }

  /// Shows an immediate test notification to verify delivery and sound/vibration.
  Future<void> showTestNotification({
    required String title,
    required String body,
  }) async {
    if (!PlatformSupport.notifications) return;
    try {
      await _plugin.show(
        AppConstants.testNotificationId,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            AppConstants.reminderChannelId,
            'Task reminders',
            channelDescription: 'Reminders for tasks with a due time.',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    } on Object {
      // Ignored in tests / when unsupported.
    }
  }

  /// Schedules a one-off notification at [at].
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
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          'Anjiz',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
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
}

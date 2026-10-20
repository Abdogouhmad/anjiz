import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../domain/services/reminder_scheduler.dart';
import '../../l10n/app_localizations.dart';
import '../utils/platform_support.dart';
import 'notification_channels.dart';
import 'notification_permissions.dart';
import 'notification_presenter.dart';
import 'reminder_scheduler.dart';

/// Thin wrapper over `flutter_local_notifications` that owns channel setup,
/// permission requests and delegates all scheduling to
/// [ReminderNotificationScheduler].
///
/// The plugin is Android/iOS-only; on other platforms every method is a no-op.
class NotificationService implements ReminderScheduler {
  /// Creates a notification service.
  NotificationService({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin() {
    _scheduler = ReminderNotificationScheduler(_plugin);
  }

  final FlutterLocalNotificationsPlugin _plugin;
  late final ReminderNotificationScheduler _scheduler;
  bool _initialized = false;

  NotificationPresenter get _presenter => NotificationPresenter(_plugin);

  /// Initialises timezones, the plugin and Android channels (idempotent).
  ///
  /// [l10n] supplies the notification-channel copy Android shows in system
  /// settings; the first init call wins, since the OS snapshots a channel's
  /// name at creation time.
  Future<void> init(AppLocalizations l10n) async {
    if (_initialized || !PlatformSupport.notifications) return;
    await _scheduler.ensureTimezone();
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
    await createNotificationChannels(_android, l10n);
    _initialized = true;
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

  /// Schedules a one-off reminder notification (see [ReminderNotificationScheduler]).
  @override
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
  }) => _scheduler.schedule(id: id, title: title, body: body, at: at);

  /// Schedules a repeating daily notification at [hour]:[minute] local time.
  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
  }) => _scheduler.scheduleDaily(id: id, title: title, body: body);

  /// Cancels a pending notification.
  @override
  Future<void> cancel(int id) => _scheduler.cancel(id);

  /// Cancels every pending notification.
  Future<void> cancelAll() => _scheduler.cancelAll();

  /// Reschedules a reminder 10 minutes later when its snooze action is tapped.
  ///
  /// The notification is re-posted under the same id so repeated snoozes keep
  /// stacking on the original reminder.
  Future<void> _onNotificationResponse(NotificationResponse response) async {
    if (response.actionId != ReminderNotificationScheduler.snoozeActionId) {
      return;
    }
    final id = response.id;
    if (id == null) return;
    await _scheduler.resnooze(id: id, title: response.payload ?? 'Reminder');
  }
}

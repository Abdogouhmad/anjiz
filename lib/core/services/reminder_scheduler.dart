import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../constants/app_constants.dart';
import '../utils/platform_support.dart';
import 'notification_permissions.dart';

/// All reminder scheduling for the app in one place.
///
/// Root cause of "scheduled task notifications never fire" (test/snooze
/// worked, so the channel/icon/permission were fine):
/// 1. nothing on the task **save path** ever called `zonedSchedule` — only
///    the manual reminder toggle in task detail and the test button did, so
///    reminders for new/edited tasks were simply never registered;
/// 2. notification ids were derived from `String.hashCode`, which changes
///    between VM runs, so cancels and reschedules missed the original alarm
///    and stale alarms could never be cleared;
/// 3. when the device timezone name could not be resolved, `tz.local` silently
///    stayed UTC and alarms fired hours off the wall clock — indistinguishable
///    from never firing.
/// This class fixes (2) and (3): callers get ids from
/// `IdGenerator.notificationIdFor`, and the timezone falls back to a
/// fixed-offset location derived from the VM's own UTC offset.
class ReminderNotificationScheduler {
  /// Creates the scheduler over [plugin].
  ReminderNotificationScheduler(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;
  bool _timezoneReady = false;

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

  /// Loads timezone data and points `tz.local` at the device's zone.
  ///
  /// Idempotent. When the platform zone name is unknown, falls back to a
  /// fixed-offset zone computed from the VM's own UTC offset instead of
  /// silently leaving `tz.local` at UTC.
  Future<void> ensureTimezone() async {
    if (_timezoneReady || !PlatformSupport.notifications) return;
    tz_data.initializeTimeZones();
    try {
      final name = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(name));
    } on Object {
      tz.setLocalLocation(_fixedOffsetLocation(DateTime.now().timeZoneOffset));
    }
    _timezoneReady = true;
  }

  tz.Location _fixedOffsetLocation(Duration offset) {
    // The Etc/GMT±N zones are inverted: Etc/GMT-5 means UTC+5.
    final hours = (offset.inMinutes / 60).round().clamp(-12, 14);
    final name = hours == 0
        ? 'UTC'
        : 'Etc/GMT${hours.isNegative ? '+' : '-'}${hours.abs()}';
    try {
      return tz.getLocation(name);
    } on Object {
      return tz.UTC;
    }
  }

  /// Schedules a one-off notification at [at], preferring exact delivery and
  /// degrading to inexact when the exact-alarm permission is missing.
  ///
  /// Instants in the past are skipped (compared in the local zone, not UTC).
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
    String channelId = AppConstants.reminderChannelId,
  }) async {
    if (!PlatformSupport.notifications) return;
    await ensureTimezone();
    final scheduled = tz.TZDateTime.from(at, tz.local);
    if (!scheduled.isAfter(tz.TZDateTime.now(tz.local))) return;
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      reminderDetails(channelId),
      androidScheduleMode: await scheduleMode(_android),
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
    await ensureTimezone();
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      _nextDailyRun(hour, minute),
      reminderDetails(AppConstants.briefingChannelId),
      androidScheduleMode: await scheduleMode(_android),
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Cancels a pending notification.
  Future<void> cancel(int id) async {
    if (!PlatformSupport.notifications) return;
    await _plugin.cancel(id);
  }

  /// Cancels every pending notification.
  Future<void> cancelAll() async {
    if (!PlatformSupport.notifications) return;
    await _plugin.cancelAll();
  }

  static const String snoozeActionId = 'snooze_10min';

  /// The snoozed reminder re-posted 10 minutes later under its original id.
  Future<void> resnooze({
    required int id,
    required String title,
    String body = 'Snoozed for 10 minutes',
  }) async {
    if (!PlatformSupport.notifications) return;
    await ensureTimezone();
    final at = tz.TZDateTime.now(tz.local).add(const Duration(minutes: 10));
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      at,
      reminderDetails(AppConstants.reminderChannelId),
      androidScheduleMode: await scheduleMode(_android),
    );
  }

  /// Exact when permitted, inexact otherwise (Android 12+ exact-alarm policy).
  static Future<AndroidScheduleMode> scheduleMode(
    AndroidFlutterLocalNotificationsPlugin? android,
  ) async {
    final allowed = android == null || await android.allowsExactAlarms();
    return allowed
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
  }

  /// Notification details for reminder/briefing channels, with the snooze
  /// action attached to task reminders.
  static NotificationDetails reminderDetails(String channelId) =>
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          'Anjiz',
          importance: Importance.high,
          priority: Priority.high,
          actions: channelId == AppConstants.reminderChannelId
              ? <AndroidNotificationAction>[
                  const AndroidNotificationAction(
                    snoozeActionId,
                    'Snooze 10 min',
                    showsUserInterface: true,
                    allowGeneratedReplies: false,
                  ),
                ]
              : null,
        ),
      );

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
}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../utils/platform_support.dart';

/// Android permission helpers for `flutter_local_notifications`.
///
/// Extracted from the notification service so both files stay small.
extension AndroidNotificationPermissions
    on AndroidFlutterLocalNotificationsPlugin {
  /// Whether the OS currently delivers this app's notifications.
  Future<bool> isEnabled() async {
    if (!PlatformSupport.notifications) return false;
    try {
      return await areNotificationsEnabled() ?? false;
    } on Object {
      return false;
    }
  }

  /// Requests the POST_NOTIFICATIONS runtime permission.
  ///
  /// Returns whether it was granted.
  Future<bool> requestNotifications() async {
    if (!PlatformSupport.notifications) return false;
    try {
      return await requestNotificationsPermission() ?? false;
    } on Object {
      return false;
    }
  }

  /// Whether exact alarms are allowed (always `true` off Android).
  Future<bool> allowsExactAlarms() async {
    if (!PlatformSupport.notifications) return true;
    try {
      return await canScheduleExactNotifications() ?? true;
    } on Object {
      return true;
    }
  }

  /// Asks Android 12+ for the SCHEDULE_EXACT_ALARM permission.
  ///
  /// Returns whether reminders may now fire at the precise minute.
  Future<bool> requestExactAlarms() async {
    if (!PlatformSupport.notifications) return true;
    try {
      return await requestExactAlarmsPermission() ?? true;
    } on Object {
      return false;
    }
  }
}

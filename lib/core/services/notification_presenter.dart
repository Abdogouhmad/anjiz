import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../constants/app_constants.dart';
import '../utils/platform_support.dart';
import 'reminder_scheduler.dart';

/// Immediate (non-scheduled) notification display helpers.
///
/// Split from the scheduling service so both files stay small and focused.
class NotificationPresenter {
  /// Creates a presenter wrapping [plugin].
  const NotificationPresenter(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  /// Shows the "a newer version is available" notification.
  ///
  /// Silently does nothing without permission: the settings screen still
  /// reports the available update, so nothing is lost.
  Future<void> showUpdateAvailable({
    required String title,
    required String body,
  }) async {
    if (!PlatformSupport.notifications) return;
    await _plugin.show(
      AppConstants.updateNotificationId,
      title,
      body,
      _details(AppConstants.updatesChannelId, Importance.low),
    );
  }

  /// Shows an immediate test notification to verify delivery and sound/vibration.
  Future<void> showTest({required String title, required String body}) async {
    if (!PlatformSupport.notifications) return;
    try {
      await _plugin.show(
        AppConstants.testNotificationId,
        title,
        body,
        _details(AppConstants.reminderChannelId, Importance.high),
      );
    } on Object {
      // Ignored in tests / when unsupported.
    }
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
                    ReminderNotificationScheduler.snoozeActionId,
                    'Snooze 10 min',
                    showsUserInterface: true,
                    allowGeneratedReplies: false,
                  ),
                ]
              : null,
        ),
      );
}

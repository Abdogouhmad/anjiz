import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../constants/app_constants.dart';

/// Creates the app's Android notification channels (idempotent).
///
/// Channels live in their own file so the notification service stays focused
/// on scheduling and permissions.
Future<void> createNotificationChannels(
  AndroidFlutterLocalNotificationsPlugin? android,
) async {
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

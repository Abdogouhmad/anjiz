import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../l10n/app_localizations.dart';
import '../constants/app_constants.dart';

/// Creates the app's Android notification channels (idempotent).
///
/// The names and descriptions come from l10n because Android surfaces them
/// verbatim in the system notification settings. Note the OS snapshots a
/// channel's copy at creation time: re-creating an existing id never renames
/// it, so only installs that create the channel for the first time see a
/// localized name.
///
/// Channels live in their own file so the notification service stays focused
/// on scheduling and permissions.
Future<void> createNotificationChannels(
  AndroidFlutterLocalNotificationsPlugin? android,
  AppLocalizations l10n,
) async {
  await android?.createNotificationChannel(
    AndroidNotificationChannel(
      AppConstants.reminderChannelId,
      l10n.notifChannelRemindersName,
      description: l10n.notifChannelRemindersDescription,
      importance: Importance.high,
    ),
  );
  await android?.createNotificationChannel(
    AndroidNotificationChannel(
      AppConstants.briefingChannelId,
      l10n.notifChannelBriefingName,
      description: l10n.notifChannelBriefingDescription,
      importance: Importance.defaultImportance,
    ),
  );
  await android?.createNotificationChannel(
    AndroidNotificationChannel(
      AppConstants.updatesChannelId,
      l10n.notifChannelUpdatesName,
      description: l10n.notifChannelUpdatesDescription,
      importance: Importance.low,
    ),
  );
  await android?.createNotificationChannel(
    AndroidNotificationChannel(
      AppConstants.pomodoroChannelLiveId,
      l10n.pomodoroChannelLiveName,
      description: l10n.pomodoroChannelLiveDescription,
      importance: Importance.low,
    ),
  );
  await android?.createNotificationChannel(
    AndroidNotificationChannel(
      AppConstants.pomodoroChannelAlertId,
      l10n.pomodoroChannelAlertName,
      description: l10n.pomodoroChannelAlertDescription,
      importance: Importance.high,
    ),
  );
}

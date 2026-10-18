import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/app_localizations.dart';
import '../constants/app_constants.dart';
import '../utils/platform_support.dart';
import 'notification_service.dart';
import 'preferences_provider.dart';
import 'service_providers.dart';

/// Keeps the recurring daily-briefing notification in sync with the setting.
///
/// The copy is supplied by the caller (the settings screen or the background
/// reconciler) so core never hard-codes user-visible text.
class DailyBriefingScheduler {
  /// Creates a scheduler driving [notifications].
  const DailyBriefingScheduler(this._notifications);

  final NotificationService _notifications;

  /// Shows the briefing when [enabled], otherwise removes it.
  Future<void> apply({
    required bool enabled,
    required String title,
    required String body,
  }) async {
    if (!enabled) {
      await _notifications.cancel(AppConstants.dailyBriefingNotificationId);
      return;
    }
    await _notifications.scheduleDaily(
      id: AppConstants.dailyBriefingNotificationId,
      title: title,
      body: body,
    );
  }
}

/// Re-reads the persisted briefing setting and reconciles the notification.
///
/// Called on every app launch and from the background refresh job so the
/// briefing survives reboots and app upgrades.
Future<void> reconcileDailyBriefing(ProviderContainer container) async {
  if (!PlatformSupport.notifications) return;
  final SharedPreferences prefs = container.read(sharedPreferencesProvider);
  final enabled = prefs.getBool(AppConstants.prefDailyBriefing) ?? false;
  final notifications = container.read(notificationServiceProvider);
  final l10n = await AppLocalizations.delegate.load(const Locale('en'));
  await notifications.init(l10n);
  await DailyBriefingScheduler(notifications).apply(
    enabled: enabled,
    title: l10n.labelDailyBriefing,
    body: l10n.dailyBriefingNotificationBody,
  );
}

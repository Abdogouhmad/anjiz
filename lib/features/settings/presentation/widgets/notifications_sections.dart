import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/daily_briefing.dart';
import '../../../../core/services/haptic_service.dart';
import '../../../../core/services/service_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/settings_controller.dart';
import 'notification_permission_section.dart';

/// The Notifications screen body: permissions verification, daily briefing,
/// instant notification test and widget configuration.
class NotificationsSections extends ConsumerWidget {
  /// Creates the notification sections.
  const NotificationsSections({required this.onOpenWidgetConfig, super.key});

  /// Opens the widget configuration screen.
  final VoidCallback onOpenWidgetConfig;

  Future<void> _sendTestNotification(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final service = ref.read(notificationServiceProvider);
    await service.showTestNotification(
      title: l10n.notificationsTitle,
      body: l10n.notificationsTestSent,
    );
    ref.read(hapticServiceProvider).success();
    if (context.mounted) {
      AnjizSnackBar.show(context, message: l10n.notificationsTestSent);
    }
  }

  Future<void> _onDailyBriefingChanged(
    BuildContext context,
    WidgetRef ref,
    bool value,
    AppLocalizations l10n,
  ) async {
    if (value) {
      final granted = await ref
          .read(notificationServiceProvider)
          .requestPermission();
      if (!granted) {
        if (context.mounted) {
          AnjizSnackBar.show(context, message: l10n.errorNotificationMessage);
        }
        return;
      }
    }
    await ref
        .read(settingsControllerProvider.notifier)
        .setDailyBriefing(enabled: value);
    // Actually schedule (or remove) the morning briefing notification.
    await DailyBriefingScheduler(ref.read(notificationServiceProvider)).apply(
      enabled: value,
      title: l10n.labelDailyBriefing,
      body: l10n.dailyBriefingNotificationBody,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const NotificationPermissionSection(),
        const SizedBox(height: AnjizSpacing.md),
        AnjizSectionHeader(title: l10n.notificationsTitle),
        AnjizSettingsCard(
          children: [
            AnjizSwitchTile(
              title: l10n.labelDailyBriefing,
              subtitle: l10n.dailyBriefingSubtitle,
              value: settings.dailyBriefing,
              switchSemanticLabel: l10n.labelDailyBriefing,
              onChanged: (v) => _onDailyBriefingChanged(context, ref, v, l10n),
            ),
          ],
        ),
        const SizedBox(height: AnjizSpacing.md),
        AnjizSectionHeader(title: l10n.notificationsTestTitle),
        AnjizSettingsCard(
          children: [
            Text(
              l10n.notificationsTestSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            AnjizButton(
              label: l10n.notificationsSendTest,
              icon: Icons.notifications_active_rounded,
              variant: AnjizButtonVariant.tonal,
              expand: true,
              onPressed: () => _sendTestNotification(context, ref, l10n),
            ),
          ],
        ),
        const SizedBox(height: AnjizSpacing.md),
        AnjizSectionHeader(title: l10n.widgetConfigTitle),
        AnjizSettingsCard(
          children: [
            AnjizSettingsNavTile(
              title: l10n.labelWidgetConfig,
              subtitle: l10n.widgetConfigSubtitle,
              leading: const AnjizIconBadge(
                icon: Icons.widgets_outlined,
                tone: AnjizTone.secondary,
                size: 36,
                iconSize: 18,
              ),
              onTap: onOpenWidgetConfig,
            ),
          ],
        ),
      ],
    );
  }
}

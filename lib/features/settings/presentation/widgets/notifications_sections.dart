import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/haptic_service.dart';
import '../../../../core/services/service_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/settings_controller.dart';

/// The Notifications screen body: permissions verification, daily briefing,
/// instant notification test and widget configuration.
class NotificationsSections extends ConsumerStatefulWidget {
  /// Creates the notification sections.
  const NotificationsSections({required this.onOpenWidgetConfig, super.key});

  /// Opens the widget configuration screen.
  final VoidCallback onOpenWidgetConfig;

  @override
  ConsumerState<NotificationsSections> createState() =>
      _NotificationsSectionsState();
}

class _NotificationsSectionsState extends ConsumerState<NotificationsSections> {
  bool? _permissionGranted;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final granted = await ref
        .read(notificationServiceProvider)
        .areNotificationsEnabled();
    if (mounted) {
      setState(() => _permissionGranted = granted);
    }
  }

  Future<void> _requestPermission() async {
    final granted = await ref
        .read(notificationServiceProvider)
        .requestPermission();
    if (mounted) {
      setState(() => _permissionGranted = granted);
    }
  }

  Future<void> _sendTestNotification(AppLocalizations l10n) async {
    final service = ref.read(notificationServiceProvider);
    await service.showTestNotification(
      title: l10n.notificationsTitle,
      body: l10n.notificationsTestSent,
    );
    final settings = ref.read(settingsControllerProvider);
    await AnjizHaptics.burst(settings.hapticLevel);
    if (mounted) {
      AnjizSnackBar.show(context, message: l10n.notificationsTestSent);
    }
  }

  Future<void> _onDailyBriefingChanged(
    bool value,
    AppLocalizations l10n,
  ) async {
    if (value) {
      final granted = await ref
          .read(notificationServiceProvider)
          .requestPermission();
      if (!granted) {
        if (mounted) {
          AnjizSnackBar.show(context, message: l10n.errorNotificationMessage);
        }
        return;
      }
      setState(() => _permissionGranted = true);
    }
    await ref
        .read(settingsControllerProvider.notifier)
        .setDailyBriefing(enabled: value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final isGranted = _permissionGranted ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnjizSectionHeader(
          title: l10n.notificationsPermissionTitle,
          trailing: AnjizTagPill(
            label: isGranted
                ? l10n.notificationsPermissionGranted
                : l10n.notificationsPermissionDenied,
            tone: isGranted ? AnjizTone.primary : AnjizTone.error,
            icon: isGranted
                ? Icons.check_circle_rounded
                : Icons.error_outline_rounded,
            compact: true,
          ),
        ),
        if (!isGranted) ...[
          AnjizSettingsCard(
            children: [
              Text(
                l10n.notificationsPermissionSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              AnjizButton(
                label: l10n.notificationsGrantAction,
                icon: Icons.security_rounded,
                variant: AnjizButtonVariant.filled,
                onPressed: _requestPermission,
              ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.md),
        ],
        AnjizSectionHeader(title: l10n.notificationsTitle),
        AnjizSettingsCard(
          children: [
            AnjizSwitchTile(
              title: l10n.labelDailyBriefing,
              subtitle: l10n.dailyBriefingSubtitle,
              value: settings.dailyBriefing,
              switchSemanticLabel: l10n.labelDailyBriefing,
              onChanged: (v) => _onDailyBriefingChanged(v, l10n),
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
              onPressed: () => _sendTestNotification(l10n),
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
              onTap: widget.onOpenWidgetConfig,
            ),
          ],
        ),
      ],
    );
  }
}

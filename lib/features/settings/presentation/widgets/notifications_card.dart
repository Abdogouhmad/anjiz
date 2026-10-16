import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/settings_controller.dart';

/// The "Notifications & Widgets" settings card.
class NotificationsCard extends ConsumerWidget {
  /// Creates the notifications card.
  const NotificationsCard({required this.onOpenWidgetConfig, super.key});

  /// Opens the widget configuration screen.
  final VoidCallback onOpenWidgetConfig;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    return AnjizSettingsCard(
      icon: Icons.notifications_none_rounded,
      title: l10n.notificationsTitle,
      headerTone: AnjizTone.tertiary,
      children: [
        AnjizSwitchTile(
          title: l10n.labelDailyBriefing,
          subtitle: l10n.dailyBriefingSubtitle,
          value: settings.dailyBriefing,
          switchSemanticLabel: l10n.labelDailyBriefing,
          onChanged: (value) => controller.setDailyBriefing(enabled: value),
        ),
        const SizedBox(height: AnjizSpacing.md),
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
    );
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/settings_controller.dart';

/// The "Shape & Expressive Motion" settings card.
class MotionCard extends ConsumerWidget {
  /// Creates the motion card.
  const MotionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final hapticLabels = [
      l10n.hapticOff,
      l10n.hapticSubtle,
      l10n.hapticExpressive,
    ];
    final level = settings.hapticLevel.clamp(0, hapticLabels.length - 1);
    return AnjizSettingsCard(
      icon: Icons.auto_awesome_outlined,
      title: l10n.shapeMotionTitle,
      headerTone: AnjizTone.secondary,
      children: [
        AnjizSwitchTile(
          title: l10n.labelBurstAnimations,
          subtitle: l10n.burstAnimationsSubtitle,
          value: settings.burstAnimations,
          switchSemanticLabel: l10n.labelBurstAnimations,
          trailing: AnjizTagPill(
            label: l10n.tagDelight,
            tone: AnjizTone.tertiary,
          ),
          onChanged: (value) => controller.setBurstAnimations(enabled: value),
        ),
        const SizedBox(height: AnjizSpacing.lg),
        AnjizSliderTile(
          title: l10n.labelSpringHaptics,
          subtitle: l10n.springHapticsSubtitle,
          value: level.toDouble(),
          min: 0,
          max: (hapticLabels.length - 1).toDouble(),
          divisions: hapticLabels.length - 1,
          valueLabel: hapticLabels[level],
          labels: hapticLabels,
          leadingIcon: Icons.vibration_rounded,
          trailingIcon: Icons.graphic_eq_rounded,
          onChanged: (value) => controller.setHapticLevel(value.round()),
        ),
      ],
    );
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/settings_controller.dart';
import 'motion_playground_card.dart';

/// The Motion screen body: interactive playground, burst animation toggle,
/// and spring haptic slider.
class MotionSections extends ConsumerWidget {
  /// Creates the motion sections.
  const MotionSections({super.key});

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const MotionPlaygroundCard(),
        const SizedBox(height: AnjizSpacing.md),
        AnjizSectionHeader(title: l10n.settingsMotion),
        AnjizSettingsCard(
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
              onChanged: (value) =>
                  controller.setBurstAnimations(enabled: value),
            ),
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
        ),
      ],
    );
  }
}

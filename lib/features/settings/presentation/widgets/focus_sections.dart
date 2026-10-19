import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/settings_controller.dart';

/// The focus-timer settings: phase lengths, long-break rhythm and auto-start.
class FocusSections extends ConsumerWidget {
  /// Creates the focus settings sections.
  const FocusSections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnjizSectionHeader(title: l10n.pomodoroTitle),
        AnjizSettingsCard(
          children: [
            AnjizSliderTile(
              title: l10n.pomodoroFocusLength,
              value: settings.focusMinutes.toDouble(),
              min: 5,
              max: 90,
              divisions: 17,
              valueLabel: l10n.pomodoroMinutesValue(settings.focusMinutes),
              leadingIcon: Icons.timer_outlined,
              trailingIcon: Icons.local_fire_department_rounded,
              onChanged: (value) => controller.setFocusMinutes(value.round()),
            ),
            AnjizSliderTile(
              title: l10n.pomodoroBreakLength,
              value: settings.breakMinutes.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              valueLabel: l10n.pomodoroMinutesValue(settings.breakMinutes),
              leadingIcon: Icons.coffee_outlined,
              trailingIcon: Icons.self_improvement_rounded,
              onChanged: (value) => controller.setBreakMinutes(value.round()),
            ),
            AnjizSliderTile(
              title: l10n.pomodoroLongBreakLength,
              value: settings.longBreakMinutes.toDouble(),
              min: 5,
              max: 60,
              divisions: 11,
              valueLabel: l10n.pomodoroMinutesValue(settings.longBreakMinutes),
              leadingIcon: Icons.spa_outlined,
              trailingIcon: Icons.nights_stay_rounded,
              onChanged: (value) =>
                  controller.setLongBreakMinutes(value.round()),
            ),
            AnjizSliderTile(
              title: l10n.pomodoroLongBreakInterval,
              value: settings.longBreakInterval.toDouble(),
              min: 2,
              max: 8,
              divisions: 6,
              valueLabel: l10n.pomodoroSessionsValue(
                settings.longBreakInterval,
              ),
              leadingIcon: Icons.repeat_rounded,
              trailingIcon: Icons.loop_rounded,
              onChanged: (value) =>
                  controller.setLongBreakInterval(value.round()),
            ),
          ],
        ),
        const SizedBox(height: AnjizSpacing.md),
        AnjizSettingsCard(
          children: [
            AnjizSwitchTile(
              title: l10n.pomodoroAutoStartNext,
              subtitle: l10n.pomodoroAutoStartNextSubtitle,
              value: settings.pomodoroAutoStart,
              switchSemanticLabel: l10n.pomodoroAutoStartNext,
              onChanged: (value) =>
                  controller.setPomodoroAutoStart(enabled: value),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/task.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/pomodoro_providers.dart';
import '../providers/pomodoro_controller.dart';
import '../sheets/pomodoro_sheet.dart';
import 'focus_availability_hint.dart';
import 'focus_switch_sheet.dart';

/// The focus-timer card on the task-detail screen.
///
/// Shows how much focus time the task has collected and starts (or reopens)
/// the native Live Update timer on Android 16+.
class FocusTaskCard extends ConsumerWidget {
  /// Creates the card for [task].
  const FocusTaskCard({required this.task, super.key});

  /// The task the timer would run for.
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final run = ref.watch(pomodoroControllerProvider);
    final availability = ref.watch(pomodoroAvailabilityProvider).value;
    final controller = ref.read(pomodoroControllerProvider.notifier);
    final isActive = run != null && controller.isFor(task.id);
    final supported = availability?.platformSupported ?? false;
    final subtitle = isActive
        ? l10n.pomodoroRunningFor
        : task.focusSessions > 0
        ? l10n.pomodoroSessionsValue(task.focusSessions)
        : l10n.settingsFocusSubtitle;
    return AnjizCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const AnjizIconBadge(
                icon: Icons.timer_outlined,
                tone: AnjizTone.tertiary,
                size: 36,
                iconSize: 18,
              ),
              const SizedBox(width: AnjizSpacing.md12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.pomodoroTitle, style: textTheme.titleMedium),
                    Text(
                      subtitle,
                      style: textTheme.labelMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (task.focusMinutes > 0)
                AnjizTagPill(
                  label: l10n.pomodoroFocusMinutesMeta(task.focusMinutes),
                  tone: AnjizTone.tertiary,
                  compact: true,
                ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.md),
          AnjizButton(
            label: isActive ? l10n.pomodoroTitle : l10n.pomodoroStartFocus,
            icon: isActive ? Icons.timelapse_rounded : Icons.play_arrow_rounded,
            expand: true,
            onPressed: supported ? () => _open(context, ref) : null,
          ),
          FocusAvailabilityHint(availability: availability),
        ],
      ),
    );
  }

  Future<void> _open(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final controller = ref.read(pomodoroControllerProvider.notifier);
    if (controller.isFor(task.id)) {
      await showPomodoroSheet(context, task: task);
      return;
    }
    if (controller.isActive) {
      final switchTask = await confirmFocusSwitch(context);
      if (!switchTask || !context.mounted) return;
    }
    final scheme = Theme.of(context).colorScheme;
    try {
      await controller.start(
        task,
        primaryColor: scheme.primary.toARGB32(),
        tertiaryColor: scheme.tertiary.toARGB32(),
      );
    } on Object {
      if (!context.mounted) return;
      AnjizSnackBar.show(context, message: l10n.pomodoroUnsupported);
      return;
    }
    if (!context.mounted) return;
    await showPomodoroSheet(context, task: task);
  }
}

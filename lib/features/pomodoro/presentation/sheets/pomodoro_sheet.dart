import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/pomodoro_config.dart';
import '../../../../domain/entities/task.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/pomodoro_controller.dart';
import '../widgets/pomodoro_timer_display.dart';

/// Opens the focus sheet for [task].
Future<void> showPomodoroSheet(BuildContext context, {required Task task}) =>
    AnjizBottomSheet.show<void>(context, child: PomodoroSheet(task: task));

/// The running-timer sheet: countdown, session and phase controls.
class PomodoroSheet extends ConsumerWidget {
  /// Creates the focus sheet.
  const PomodoroSheet({required this.task, super.key});

  /// The task in focus.
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final run = ref.watch(pomodoroControllerProvider);
    final config = ref.watch(pomodoroConfigProvider);
    final controller = ref.read(pomodoroControllerProvider.notifier);
    ref.listen(pomodoroControllerProvider, (previous, next) {
      if (next != null || previous == null) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) Navigator.of(context).maybePop();
      });
    });
    if (run == null) return const SizedBox.shrink();
    return AnjizSheetContent(
      title: l10n.pomodoroTitle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            task.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AnjizSpacing.lg),
          Center(
            child: PomodoroTimerDisplay(run: run, config: config),
          ),
          const SizedBox(height: AnjizSpacing.lg),
          AnjizButton(
            label: run.paused
                ? l10n.pomodoroActionResume
                : l10n.pomodoroActionPause,
            icon: run.paused ? Icons.play_arrow_rounded : Icons.pause_rounded,
            expand: true,
            onPressed: run.paused ? controller.resume : controller.pause,
          ),
          const SizedBox(height: AnjizSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AnjizButton(
                  label: l10n.pomodoroActionSkip,
                  icon: Icons.skip_next_rounded,
                  variant: AnjizButtonVariant.tonal,
                  expand: true,
                  onPressed: controller.skip,
                ),
              ),
              const SizedBox(width: AnjizSpacing.sm),
              Expanded(
                child: AnjizButton(
                  label: l10n.pomodoroActionDone,
                  icon: Icons.check_rounded,
                  expand: true,
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await controller.complete(task.id);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

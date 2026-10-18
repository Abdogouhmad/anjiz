import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/task_actions.dart';
import '../../../../domain/entities/task.dart';
import '../../../../l10n/app_localizations.dart';

/// The floating action toolbar pinned to the bottom of the task-detail screen:
/// complete, star, snooze and delete.
class TaskDetailToolbar extends ConsumerWidget {
  /// Creates a toolbar for [task].
  const TaskDetailToolbar({required this.task, super.key});

  /// The task the actions apply to.
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final actions = ref.read(taskActionsProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AnjizSpacing.md),
        child: AnjizFloatingToolbar(
          primaryLabel: l10n.actionMarkComplete,
          primaryIcon: Icons.check_circle_outline,
          onPrimaryPressed: () async {
            await actions.toggleDone(task, isDone: true);
            if (context.mounted) context.pop();
          },
          actions: [
            (
              icon: task.isStarred
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
              tooltip: task.isStarred
                  ? l10n.actionUnstarTask
                  : l10n.actionStarTask,
              onPressed: () =>
                  actions.toggleStar(task, isStarred: !task.isStarred),
            ),
            (
              icon: Icons.snooze_rounded,
              tooltip: l10n.actionSnooze,
              onPressed: () => _snooze(ref, task),
            ),
            (
              icon: Icons.delete_outline_rounded,
              tooltip: l10n.actionDelete,
              onPressed: () async {
                await actions.delete(task);
                if (context.mounted) context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _snooze(WidgetRef ref, Task task) {
    final due = task.dueAt ?? DateTime.now();
    ref
        .read(taskActionsProvider)
        .update(task.copyWith(dueAt: due.add(const Duration(days: 1))));
  }
}

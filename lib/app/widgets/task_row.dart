import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/task.dart';
import '../../domain/entities/task_list.dart';
import '../../l10n/app_localizations.dart';
import '../providers/task_actions.dart';
import '../providers/task_queries.dart';
import '../../core/utils/task_format.dart';
import 'task_meta_chips.dart';

/// The composed, actionable task row shared by every task surface: scalloped
/// checkbox, swipe-to-complete/delete, star toggle and metadata chips.
class TaskRow extends ConsumerWidget {
  /// Creates a task row.
  const TaskRow({
    required this.task,
    this.onTap,
    this.showList = true,
    this.showTime = true,
    this.showPriority = true,
    this.accentColor,
    this.trailing,
    this.flat = false,
    super.key,
  });

  /// The task to render.
  final Task task;

  /// Called when the row is tapped (usually to open task detail).
  final VoidCallback? onTap;

  /// Whether to show the owning-list chip.
  final bool showList;

  /// Whether to show the due-time chip.
  final bool showTime;

  /// Whether to show the priority chip.
  final bool showPriority;

  /// Optional start-edge accent colour.
  final Color? accentColor;

  /// Optional trailing widget.
  final Widget? trailing;

  /// Renders the row on the lower tonal step (used for completed rows).
  final bool flat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.watch(taskActionsProvider);
    return AnjizSwipeRow(
      dismissKey: ValueKey<String>(task.id),
      onComplete: () => actions.toggleDone(task, isDone: true),
      onDelete: () => _delete(context, actions),
      child: AnjizTaskTile(
        title: task.title,
        isDone: task.isDone,
        isStarred: task.isStarred,
        flat: flat,
        accentColor: accentColor,
        trailing: trailing,
        onTap: onTap,
        starTooltip: _starTooltip(context),
        onToggle: (value) => actions.toggleDone(task, isDone: value),
        onStarToggle: () =>
            actions.toggleStar(task, isStarred: !task.isStarred),
        meta: _meta(context, ref),
      ),
    );
  }

  List<Widget> _meta(BuildContext context, WidgetRef ref) {
    final lists = ref.watch(taskListsProvider).value ?? const <TaskList>[];
    TaskList? list;
    for (final candidate in lists) {
      if (candidate.id == task.listId) {
        list = candidate;
        break;
      }
    }
    final completedAt = task.completedAt;
    if (task.isDone && completedAt != null) {
      final l10n = AppLocalizations.of(context);
      return [
        AnjizMetaChip(
          label: l10n.labelCompletedAt(TaskFormat.time(context, completedAt)),
          icon: Icons.check_circle_outline,
        ),
      ];
    }
    return buildTaskMetaChips(
      context,
      task: task,
      list: showList ? list : null,
      showTime: showTime,
      showPriority: showPriority,
    );
  }

  String _starTooltip(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return task.isStarred ? l10n.actionUnstarTask : l10n.actionStarTask;
  }

  Future<void> _delete(BuildContext context, TaskActions actions) async {
    final l10n = AppLocalizations.of(context);
    await actions.delete(task);
    if (!context.mounted) return;
    AnjizSnackBar.show(
      context,
      message: l10n.taskDeleted,
      actionLabel: l10n.actionUndo,
      onAction: () => actions.update(task),
    );
  }
}

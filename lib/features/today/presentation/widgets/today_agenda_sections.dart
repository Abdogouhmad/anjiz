import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/task_row.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/today_agenda.dart';
import '../../../../l10n/app_localizations.dart';

/// The grouped agenda sections rendered inside the Today screen.
class TodayAgendaSections extends StatelessWidget {
  /// Creates the agenda sections.
  const TodayAgendaSections({
    required this.agenda,
    required this.onOpenTask,
    required this.onRescheduleAll,
    super.key,
  });

  /// The grouped agenda to render.
  final TodayAgenda agenda;

  /// Called when a task row is tapped.
  final ValueChanged<Task> onOpenTask;

  /// Called to pull every overdue task onto today.
  final VoidCallback onRescheduleAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final planned = <Task>[...agenda.completed, ...agenda.scheduled];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (agenda.overdue.isNotEmpty) ...[
          AnjizSectionHeader(
            title: l10n.sectionOverdue,
            count: l10n.tasksCount(agenda.overdue.length),
            dotColor: scheme.error,
            trailing: AnjizMetaChip(
              label: l10n.actionRescheduleAll,
              icon: Icons.event_repeat_outlined,
              tone: AnjizTone.primary,
              onTap: onRescheduleAll,
            ),
          ),
          _TaskGroup(
            tasks: agenda.overdue,
            accentColor: scheme.error,
            onOpenTask: onOpenTask,
          ),
        ],
        if (planned.isNotEmpty) ...[
          const SizedBox(height: AnjizSpacing.sm),
          AnjizSectionHeader(
            title: l10n.sectionPlannedToday,
            count: l10n.tasksCount(planned.length),
            trailing: AnjizMetaChip(
              label: l10n.sortByPriority,
              icon: Icons.sort_rounded,
            ),
          ),
          _TaskGroup(tasks: planned, onOpenTask: onOpenTask),
        ],
        if (agenda.anytime.isNotEmpty) ...[
          const SizedBox(height: AnjizSpacing.sm),
          AnjizSectionHeader(
            title: l10n.sectionLaterToday,
            count: l10n.tasksCount(agenda.anytime.length),
            trailing: AnjizMetaChip(label: l10n.labelUntimed),
          ),
          _TaskGroup(tasks: agenda.anytime, onOpenTask: onOpenTask),
        ],
      ],
    );
  }
}

class _TaskGroup extends StatelessWidget {
  const _TaskGroup({
    required this.tasks,
    required this.onOpenTask,
    this.accentColor,
  });

  final List<Task> tasks;
  final ValueChanged<Task> onOpenTask;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final task in tasks)
          Padding(
            padding: const EdgeInsets.only(bottom: AnjizSpacing.sm),
            child: TaskRow(
              task: task,
              flat: task.isDone,
              accentColor: accentColor,
              onTap: () => onOpenTask(task),
            ),
          ),
      ],
    );
  }
}

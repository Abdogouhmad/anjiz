import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/task_row.dart';
import '../../../../core/utils/task_format.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/upcoming_day.dart';
import '../../../../l10n/app_localizations.dart';

/// One day block in the Upcoming agenda: a dated header plus its task rows, or
/// a calm empty-day prompt.
class UpcomingDaySection extends StatelessWidget {
  /// Creates a day section.
  const UpcomingDaySection({
    required this.day,
    required this.now,
    required this.onOpenTask,
    required this.onAddTask,
    super.key,
  });

  /// The day and its tasks.
  final UpcomingDay day;

  /// The current instant, used for relative day headings.
  final DateTime now;

  /// Called when a task row is tapped.
  final ValueChanged<Task> onOpenTask;

  /// Called to quick-add a task on this day.
  final VoidCallback onAddTask;

  bool get _isWeekend =>
      day.date.weekday == DateTime.saturday ||
      day.date.weekday == DateTime.sunday;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: AnjizSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnjizSectionHeader(
            title: TaskFormat.dayHeading(context, day.date, now),
            count: l10n.tasksCount(day.tasks.length),
            dotColor: scheme.primary,
          ),
          if (day.tasks.isEmpty)
            _EmptyDayCard(
              message: _isWeekend ? l10n.weekendMessage : l10n.emptyDayTitle,
              onAddTask: onAddTask,
            )
          else
            for (final task in day.tasks)
              Padding(
                padding: const EdgeInsets.only(bottom: AnjizSpacing.sm),
                child: TaskRow(task: task, onTap: () => onOpenTask(task)),
              ),
        ],
      ),
    );
  }
}

class _EmptyDayCard extends StatelessWidget {
  const _EmptyDayCard({required this.message, required this.onAddTask});

  final String message;
  final VoidCallback onAddTask;

  @override
  Widget build(BuildContext context) {
    return AnjizCard(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      padding: const EdgeInsets.all(AnjizSpacing.md12),
      child: Row(
        children: [
          const AnjizIconBadge(
            icon: Icons.local_cafe_outlined,
            tone: AnjizTone.secondary,
            size: 36,
            iconSize: 18,
          ),
          const SizedBox(width: AnjizSpacing.md12),
          Expanded(
            child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
          ),
          IconButton(
            onPressed: onAddTask,
            tooltip: AppLocalizations.of(context).actionNewTask,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}

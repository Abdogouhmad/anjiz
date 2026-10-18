import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/task_format.dart';
import '../../../../domain/entities/task.dart';
import '../../../../l10n/app_localizations.dart';
import 'task_recurrence.dart';

/// The stacked information rows on the task-detail screen: due date, repeat
/// rule and owning list.
class TaskDetailInfoCard extends StatelessWidget {
  /// Creates the info card.
  const TaskDetailInfoCard({
    required this.task,
    required this.listName,
    required this.onEditDue,
    required this.onEditRecurrence,
    required this.onChangeList,
    super.key,
  });

  /// The task being viewed.
  final Task task;

  /// Display name of the owning list, when resolved.
  final String? listName;

  /// Opens the due date/time picker.
  final VoidCallback onEditDue;

  /// Opens the recurrence picker.
  final VoidCallback onEditRecurrence;

  /// Opens the list picker.
  final VoidCallback onChangeList;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final due = task.dueAt;
    return AnjizCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InfoRow(
            icon: Icons.event_outlined,
            label: l10n.labelDueDateTime,
            value: due == null
                ? l10n.labelNoDueDate
                : TaskFormat.dueLabel(context, due, now, hasTime: task.hasTime),
            trailing: due == null
                ? null
                : AnjizTagPill(
                    label: due.isBefore(now)
                        ? l10n.labelOverdueBy(
                            TaskFormat.countdown(context, now, due),
                          )
                        : l10n.labelDueIn(
                            TaskFormat.countdown(context, due, now),
                          ),
                    tone: due.isBefore(now)
                        ? AnjizTone.error
                        : AnjizTone.tertiary,
                  ),
            onTap: onEditDue,
          ),
          const SizedBox(height: AnjizSpacing.md12),
          _InfoRow(
            icon: Icons.repeat_rounded,
            label: l10n.labelRecurrence,
            value: RepeatRules.label(l10n, task.repeatRule),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: onEditRecurrence,
          ),
          const SizedBox(height: AnjizSpacing.md12),
          _InfoRow(
            icon: Icons.folder_outlined,
            label: l10n.labelProjectList,
            value: listName ?? l10n.labelList,
            trailing: TextButton(
              onPressed: onChangeList,
              child: Text(l10n.actionChange),
            ),
            onTap: onChangeList,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AnjizListTile(
      onTap: onTap,
      leading: AnjizIconBadge(
        icon: icon,
        tone: AnjizTone.secondary,
        size: 36,
        iconSize: 18,
      ),
      title: Text(
        label,
        style: textTheme.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
      ),
      subtitle: Text(
        value,
        style: textTheme.titleMedium?.copyWith(color: scheme.onSurface),
      ),
      trailing: trailing,
    );
  }
}

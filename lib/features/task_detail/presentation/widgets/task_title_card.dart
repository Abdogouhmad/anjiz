import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/task_format.dart';
import '../../../../domain/entities/task.dart';
import '../../../../l10n/app_localizations.dart';

/// The editable title card at the top of the task-detail screen.
///
/// Tapping the card opens the title editor; the footer shows a "tap to edit"
/// hint and the task's creation time.
class TaskTitleCard extends StatelessWidget {
  /// Creates a title card for [task].
  const TaskTitleCard({required this.task, required this.onEdit, super.key});

  /// The task being displayed.
  final Task task;

  /// Called when the card is tapped.
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AnjizCard(
      onTap: onEdit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: textTheme.headlineSmall?.copyWith(
              color: task.isDone ? scheme.onSurfaceVariant : scheme.onSurface,
              decoration: task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              decorationColor: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AnjizSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.edit_outlined,
                size: 14,
                color: scheme.onSurfaceVariant,
              ),
              const SizedBox(width: AnjizSpacing.xs),
              Flexible(
                child: Text(
                  l10n.labelTapToEdit,
                  style: textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              const _MetaDot(),
              Flexible(
                child: Text(
                  l10n.labelCreatedAt(TaskFormat.time(context, task.createdAt)),
                  style: textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaDot extends StatelessWidget {
  const _MetaDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: AnjizSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        shape: BoxShape.circle,
      ),
    );
  }
}

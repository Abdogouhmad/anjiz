import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/task_subtasks_provider.dart';
import '../sheets/add_subtask_sheet.dart';
import 'subtask_row.dart';

/// The Subtasks card: progress ratio, checklist and quick-add affordance.
class SubtaskListCard extends ConsumerWidget {
  /// Creates the subtasks card for [taskId].
  const SubtaskListCard({required this.taskId, super.key});

  /// The parent task.
  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final subtasks = ref.watch(taskSubtasksProvider(taskId)).value ?? [];
    final done = subtasks.where((subtask) => subtask.isDone).length;
    final total = subtasks.length;
    return AnjizCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnjizListTile(
            leading: const AnjizIconBadge(
              icon: Icons.checklist_rounded,
              tone: AnjizTone.primary,
              size: 36,
              iconSize: 18,
            ),
            title: Text(l10n.sectionSubtasks),
            trailing: AnjizCountBadge(
              label: l10n.subtasksProgress(done, total),
            ),
          ),
          const SizedBox(height: AnjizSpacing.sm),
          AnjizWavyProgress(value: total == 0 ? 0 : done / total),
          const SizedBox(height: AnjizSpacing.sm),
          for (final subtask in subtasks) SubtaskRow(subtask: subtask),
          const SizedBox(height: AnjizSpacing.sm),
          AnjizButton(
            label: l10n.actionAddSubtask,
            icon: Icons.add_rounded,
            variant: AnjizButtonVariant.tonal,
            expand: true,
            onPressed: () => showAddSubtaskSheet(
              context,
              taskId: taskId,
              sortOrder: subtasks.length,
            ),
          ),
        ],
      ),
    );
  }
}

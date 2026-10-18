import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/widgets/task_meta_chips.dart';
import '../../../../domain/entities/priority.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../app/providers/task_queries.dart';

/// The "Task metadata" row: list and priority selectors.
class TaskMetadataRow extends ConsumerWidget {
  /// Creates the metadata row.
  const TaskMetadataRow({
    required this.listId,
    required this.priority,
    required this.due,
    required this.hasTime,
    required this.onPickList,
    required this.onPickPriority,
    super.key,
  });

  /// Currently selected list id.
  final String listId;

  /// Currently selected priority.
  final Priority priority;

  /// Current due date (used only for display context).
  final DateTime? due;

  /// Whether the due date carries a time.
  final bool hasTime;

  /// Opens the list picker.
  final VoidCallback onPickList;

  /// Opens the priority picker.
  final VoidCallback onPickPriority;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final lists = ref.watch(taskListsProvider).value ?? const [];
    String? listName;
    for (final list in lists) {
      if (list.id == listId) {
        listName = list.name;
        break;
      }
    }
    final hasPriority = priority != Priority.none;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.labelTaskMetadata.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            letterSpacing: 1,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AnjizSpacing.sm),
        Wrap(
          spacing: AnjizSpacing.sm,
          runSpacing: AnjizSpacing.sm,
          children: [
            AnjizSelectChip(
              label: listName ?? l10n.labelList,
              icon: Icons.folder_outlined,
              trailingIcon: Icons.expand_more,
              onTap: onPickList,
            ),
            AnjizSelectChip(
              label: priorityLabel(l10n, priority),
              icon: Icons.star_outline_rounded,
              trailingIcon: Icons.expand_more,
              tone: hasPriority ? AnjizTone.tertiary : AnjizTone.neutral,
              selected: hasPriority,
              onTap: onPickPriority,
            ),
          ],
        ),
      ],
    );
  }
}

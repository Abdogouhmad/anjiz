import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers/task_queries.dart';
import '../../domain/entities/priority.dart';
import '../../l10n/app_localizations.dart';
import 'task_meta_chips.dart';

/// Shows a sheet to choose a target list, returning its id.
Future<String?> showListPicker(BuildContext context, WidgetRef ref) {
  final l10n = AppLocalizations.of(context);
  final lists = ref.read(taskListsProvider).value ?? const [];
  return AnjizBottomSheet.show<String>(
    context,
    child: AnjizSheetContent(
      title: l10n.labelList,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < lists.length; i++) ...[
            AnjizListTile(
              leading: const AnjizIconBadge(
                icon: Icons.folder_outlined,
                tone: AnjizTone.primary,
                size: 36,
                iconSize: 18,
              ),
              title: Text(lists[i].name),
              onTap: () => Navigator.of(context).pop(lists[i].id),
            ),
            if (i < lists.length - 1) const SizedBox(height: AnjizSpacing.sm),
          ],
        ],
      ),
    ),
  );
}

/// Shows a sheet to choose a priority, returning the selection.
Future<Priority?> showPriorityPicker(
  BuildContext context,
  WidgetRef ref,
  Priority current,
) {
  final l10n = AppLocalizations.of(context);
  const priorities = Priority.values;
  return AnjizBottomSheet.show<Priority>(
    context,
    child: AnjizSheetContent(
      title: l10n.labelPriority,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < priorities.length; i++) ...[
            AnjizListTile(
              leading: AnjizIconBadge(
                icon: Icons.star_outline_rounded,
                tone: priorities[i] == Priority.none
                    ? AnjizTone.neutral
                    : AnjizTone.tertiary,
                size: 36,
                iconSize: 18,
              ),
              title: Text(priorityLabel(l10n, priorities[i])),
              trailing: priorities[i] == current
                  ? const Icon(Icons.check_rounded)
                  : null,
              onTap: () => Navigator.of(context).pop(priorities[i]),
            ),
            if (i < priorities.length - 1)
              const SizedBox(height: AnjizSpacing.md),
          ],
        ],
      ),
    ),
  );
}

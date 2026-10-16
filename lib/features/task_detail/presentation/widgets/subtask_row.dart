import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/use_case_providers.dart';
import '../../../../domain/entities/subtask.dart';

/// A single editable checklist row inside the Subtasks card.
class SubtaskRow extends ConsumerWidget {
  /// Creates a subtask row.
  const SubtaskRow({required this.subtask, super.key});

  /// The subtask to render.
  final Subtask subtask;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return AnjizListTile(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: AnjizSpacing.xs,
      ),
      leading: AnjizTaskCheckbox(
        value: subtask.isDone,
        semanticLabel: subtask.title,
        onChanged: (value) =>
            ref.read(toggleSubtaskProvider).call(subtask, isDone: value),
      ),
      title: Text(
        subtask.title,
        style: textTheme.bodyLarge?.copyWith(
          color: subtask.isDone ? scheme.onSurfaceVariant : scheme.onSurface,
          decoration: subtask.isDone
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          decorationColor: scheme.onSurfaceVariant,
        ),
      ),
      trailing: IconButton(
        onPressed: () => ref.read(deleteSubtaskProvider).call(subtask),
        tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
        icon: const Icon(Icons.close_rounded, size: 18),
      ),
    );
  }
}

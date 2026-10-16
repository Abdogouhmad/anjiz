import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import '../inputs/anjiz_segmented_selector.dart';

/// A connected button group (segmented control): one unified pill container
/// where the active segment adopts the emerald container colour.
class AnjizButtonGroup<T> extends StatelessWidget {
  /// Creates a connected button group.
  const AnjizButtonGroup({
    required this.segments,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  /// The available segments.
  final List<AnjizSegment<T>> segments;

  /// The currently selected value.
  final T selected;

  /// Called when a segment is chosen.
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final children = <Widget>[];
    for (var i = 0; i < segments.length; i++) {
      final segment = segments[i];
      final isSelected = segment.value == selected;
      children.add(
        Expanded(
          child: _segmentButton(
            context,
            segment: segment,
            selected: isSelected,
            onTap: () => onChanged(segment.value),
          ),
        ),
      );
      if (i != segments.length - 1) {
        final nextSelected = segments[i + 1].value == selected;
        children.add(
          Container(
            width: 1,
            height: 24,
            color: (isSelected || nextSelected)
                ? Colors.transparent
                : scheme.outlineVariant,
          ),
        );
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: AnjizShapes.pill,
      ),
      child: Row(children: children),
    );
  }

  Widget _segmentButton(
    BuildContext context, {
    required AnjizSegment<T> segment,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: AnjizShapes.pill,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: AnjizSpacing.md12,
              horizontal: AnjizSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: selected ? scheme.primaryContainer : null,
              borderRadius: AnjizShapes.pill,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (segment.icon != null) ...[
                  Icon(
                    segment.icon,
                    size: 18,
                    color: selected
                        ? scheme.onPrimaryContainer
                        : scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AnjizSpacing.sm),
                ],
                Flexible(
                  child: Text(
                    segment.label,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelLarge?.copyWith(
                      color: selected
                          ? scheme.onPrimaryContainer
                          : scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

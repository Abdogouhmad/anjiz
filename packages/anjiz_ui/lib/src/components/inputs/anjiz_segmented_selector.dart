import 'package:flutter/material.dart';

import '../../services/anjiz_haptics.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// A single segment descriptor for [AnjizSegmentedSelector].
typedef AnjizSegment<T> = ({T value, String label, IconData? icon});

/// A pill-shaped segmented selector (settings-style): a tonal track holding a
/// raised, shadowed pill for the active segment.
class AnjizSegmentedSelector<T> extends StatelessWidget {
  /// Creates a segmented selector.
  const AnjizSegmentedSelector({
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
    return Container(
      padding: const EdgeInsets.all(AnjizSpacing.xs),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: AnjizShapes.pill,
      ),
      child: Row(
        children: [
          for (final segment in segments)
            Expanded(
              child: _Segment(
                label: segment.label,
                icon: segment.icon,
                selected: segment.value == selected,
                onTap: () {
                  AnjizHaptics.selection();
                  onChanged(segment.value);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
            curve: Curves.easeOut,
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: AnjizSpacing.sm + 2,
            ),
            decoration: BoxDecoration(
              color: selected ? scheme.surfaceContainerLowest : null,
              borderRadius: AnjizShapes.pill,
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: scheme.onSurface.withValues(alpha: 0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 18,
                    color: selected
                        ? scheme.onSurface
                        : scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AnjizSpacing.sm),
                ],
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.labelLarge?.copyWith(
                      color: selected
                          ? scheme.onSurface
                          : scheme.onSurfaceVariant,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
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

import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import '../common/anjiz_tone.dart';

/// A tappable pill used to pick a value (due date, list, priority, tag…).
class AnjizSelectChip extends StatelessWidget {
  /// Creates a select chip.
  const AnjizSelectChip({
    required this.label,
    this.icon,
    this.trailingIcon,
    this.onTap,
    this.tone = AnjizTone.neutral,
    this.selected = false,
    super.key,
  });

  /// Localised label.
  final String label;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional trailing icon (e.g. a dropdown caret).
  final IconData? trailingIcon;

  /// Tap handler.
  final VoidCallback? onTap;

  /// Semantic tone.
  final AnjizTone tone;

  /// Renders the selected (filled) treatment.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = tone.resolve(scheme);
    final background = selected
        ? colors.container
        : scheme.surfaceContainerHigh;
    final foreground = selected ? colors.onContainer : scheme.onSurfaceVariant;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: AnjizShapes.pill,
        child: Container(
          height: 40,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AnjizSpacing.md12,
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: AnjizShapes.pill,
            border: selected
                ? null
                : Border.all(color: scheme.outlineVariant, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: foreground),
                const SizedBox(width: AnjizSpacing.sm),
              ],
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(color: foreground),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: AnjizSpacing.xs),
                Icon(trailingIcon, size: 18, color: foreground),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

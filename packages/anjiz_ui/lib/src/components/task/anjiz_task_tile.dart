import 'package:flutter/material.dart';

import '../../tokens/anjiz_elevation.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import 'anjiz_task_checkbox.dart';

/// A task row card: scalloped checkbox, title with optional strikethrough,
/// metadata chips and a star toggle. Feature screens compose this rather than
/// building their own task rows.
class AnjizTaskTile extends StatelessWidget {
  /// Creates a task row.
  const AnjizTaskTile({
    required this.title,
    required this.isDone,
    this.isStarred = false,
    this.onToggle,
    this.onStarToggle,
    this.onTap,
    this.subtitle,
    this.meta = const <Widget>[],
    this.trailing,
    this.accentColor,
    this.strikethroughOnDone = true,
    this.flat = false,
    this.starTooltip,
    super.key,
  });

  /// Task title.
  final String title;

  /// Whether the task is complete.
  final bool isDone;

  /// Whether the task is starred.
  final bool isStarred;

  /// Completion toggle handler.
  final ValueChanged<bool>? onToggle;

  /// Star toggle handler.
  final VoidCallback? onStarToggle;

  /// Row tap handler.
  final VoidCallback? onTap;

  /// Optional secondary line below the title.
  final Widget? subtitle;

  /// Metadata chips shown beneath the title.
  final List<Widget> meta;

  /// Optional trailing widget (e.g. a time label).
  final Widget? trailing;

  /// Optional start-edge accent bar colour (e.g. priority or overdue).
  final Color? accentColor;

  /// Whether to strike through the title once complete.
  final bool strikethroughOnDone;

  /// Uses the lower tonal step (for completed/resting rows).
  final bool flat;

  /// Accessibility tooltip for the star toggle (localised by the caller).
  final String? starTooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleMedium!.copyWith(
      color: isDone ? scheme.onSurfaceVariant : scheme.onSurface,
      decoration: isDone && strikethroughOnDone
          ? TextDecoration.lineThrough
          : TextDecoration.none,
      decorationColor: scheme.onSurfaceVariant,
    );

    return Container(
      decoration: BoxDecoration(
        color: flat
            ? scheme.surfaceContainerLow
            : scheme.surfaceContainerLowest,
        borderRadius: AnjizShapes.card,
        boxShadow: flat ? null : AnjizElevation.ambient(scheme.onSurface),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: AnjizShapes.card,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AnjizSpacing.sm,
              AnjizSpacing.md12,
              AnjizSpacing.md,
              AnjizSpacing.md12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (accentColor != null) ...[
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: AnjizSpacing.xs,
                    ),
                    child: Container(
                      width: 4,
                      height: 44,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: AnjizShapes.pill,
                      ),
                    ),
                  ),
                  const SizedBox(width: AnjizSpacing.xs),
                ],
                Padding(
                  padding: const EdgeInsets.only(top: AnjizSpacing.xs),
                  child: AnjizTaskCheckbox(
                    value: isDone,
                    onChanged: onToggle,
                    semanticLabel: title,
                  ),
                ),
                const SizedBox(width: AnjizSpacing.xs),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: titleStyle),
                      if (subtitle != null) ...[
                        const SizedBox(height: AnjizSpacing.xs),
                        DefaultTextStyle.merge(
                          style: textTheme.bodyMedium!.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                          child: subtitle!,
                        ),
                      ],
                      if (meta.isNotEmpty) ...[
                        const SizedBox(height: AnjizSpacing.sm),
                        Wrap(
                          spacing: AnjizSpacing.sm,
                          runSpacing: AnjizSpacing.sm,
                          children: meta,
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
                if (onStarToggle != null)
                  IconButton(
                    onPressed: onStarToggle,
                    visualDensity: VisualDensity.compact,
                    tooltip: starTooltip,
                    icon: Icon(
                      isStarred
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      color: isStarred ? scheme.tertiary : scheme.outline,
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

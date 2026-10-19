import 'package:flutter/material.dart';

import '../../services/anjiz_haptics.dart';
import '../../tokens/anjiz_elevation.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import 'anjiz_task_accent_bar.dart';
import 'anjiz_task_checkbox.dart';
import 'anjiz_task_tile_body.dart';

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
    this.onLongPress,
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

  /// Long-press handler (e.g. selection/reorder); fires heavy haptics.
  final VoidCallback? onLongPress;

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
          onLongPress: onLongPress == null
              ? null
              : () {
                  AnjizHaptics.heavy();
                  onLongPress!();
                },
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
                  AnjizTaskAccentBar(color: accentColor!),
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
                  child: AnjizTaskTileBody(
                    title: title,
                    isDone: isDone,
                    strikethroughOnDone: strikethroughOnDone,
                    subtitle: subtitle,
                    meta: meta,
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

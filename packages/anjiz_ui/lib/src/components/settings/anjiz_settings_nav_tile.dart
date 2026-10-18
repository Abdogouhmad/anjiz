import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// A tappable settings row with a leading icon, title, subtitle and a trailing
/// chevron, resting on the lower tonal step.
///
/// Title and subtitle are single-line and ellipsize, so a group of rows keeps a
/// uniform height whether the supporting copy names a value or describes a
/// screen.
class AnjizSettingsNavTile extends StatelessWidget {
  /// Creates a settings navigation row.
  const AnjizSettingsNavTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  /// Primary label.
  final String title;

  /// Optional supporting copy.
  final String? subtitle;

  /// Optional leading widget.
  final Widget? leading;

  /// Optional trailing widget. Defaults to a directional chevron.
  final Widget? trailing;

  /// Tap handler.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: anjizSettingsTileRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AnjizSpacing.md12,
            vertical: AnjizSpacing.md12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: AnjizSpacing.md12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AnjizSpacing.xs),
                      Text(
                        subtitle!,
                        style: textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AnjizSpacing.md12),
              trailing ??
                  Icon(
                    Icons.chevron_right_rounded,
                    color: scheme.onSurfaceVariant,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Radius token reused by settings rows.
const BorderRadius anjizSettingsTileRadius = BorderRadius.all(
  Radius.circular(AnjizShapes.large),
);

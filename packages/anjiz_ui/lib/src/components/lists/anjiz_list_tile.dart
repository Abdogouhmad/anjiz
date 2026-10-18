import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';

/// A flexible leading/title/subtitle/trailing row used across features.
class AnjizListTile extends StatelessWidget {
  /// Creates a list tile.
  const AnjizListTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.titleColor,
    this.titleStyle,
    this.contentPadding = EdgeInsets.zero,
    super.key,
  });

  /// Primary line.
  final Widget title;

  /// Secondary line.
  final Widget? subtitle;

  /// Leading slot.
  final Widget? leading;

  /// Trailing slot.
  final Widget? trailing;

  /// Tap handler.
  final VoidCallback? onTap;

  /// Overrides the title colour.
  final Color? titleColor;

  /// Overrides the title text style.
  final TextStyle? titleStyle;

  /// Padding around the row.
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: contentPadding,
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
                    DefaultTextStyle.merge(
                      style: titleStyle ?? textTheme.titleMedium!,
                      child: title,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AnjizSpacing.xs),
                      DefaultTextStyle.merge(
                        style: textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: AnjizSpacing.md12),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

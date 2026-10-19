import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';

/// The label content of an [AnjizButton]: optional leading icon, label and
/// optional trailing icon, or a spinner while loading.
///
/// Internal building block; not exported from the package barrel.
class AnjizButtonContent extends StatelessWidget {
  /// Creates the button content.
  const AnjizButtonContent({
    required this.label,
    required this.loading,
    required this.expand,
    required this.style,
    this.icon,
    this.trailingIcon,
    super.key,
  });

  /// Button label.
  final String label;

  /// Whether to show the loading spinner instead of the label.
  final bool loading;

  /// Whether the content should fill the available width.
  final bool expand;

  /// Leading icon.
  final IconData? icon;

  /// Trailing icon.
  final IconData? trailingIcon;

  /// Resolved button style, used to colour the spinner.
  final ButtonStyle style;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final foreground = style.foregroundColor?.resolve(
      const <WidgetState>{},
    );
    if (loading) {
      return SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(strokeWidth: 2, color: foreground),
      );
    }
    return Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: AnjizSpacing.sm),
        ],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelLarge?.copyWith(color: foreground),
          ),
        ),
        if (trailingIcon != null) ...[
          const SizedBox(width: AnjizSpacing.sm),
          Icon(trailingIcon, size: 20),
        ],
      ],
    );
  }
}

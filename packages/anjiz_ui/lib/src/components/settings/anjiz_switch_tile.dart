import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';

/// A title/subtitle row with a trailing switch.
class AnjizSwitchTile extends StatelessWidget {
  /// Creates a switch tile.
  const AnjizSwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.trailing,
    this.switchSemanticLabel,
    super.key,
  });

  /// Primary label.
  final String title;

  /// Optional supporting copy.
  final String? subtitle;

  /// Current switch value.
  final bool value;

  /// Change handler.
  final ValueChanged<bool>? onChanged;

  /// Optional extra trailing widget under the switch row.
  final Widget? trailing;

  /// Accessibility label for the switch.
  final String? switchSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.titleSmall),
                  if (subtitle != null) ...[
                    const SizedBox(height: AnjizSpacing.xs),
                    Text(
                      subtitle!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AnjizSpacing.md),
            MergeSemantics(
              child: Switch(value: value, onChanged: onChanged),
            ),
          ],
        ),
        if (trailing != null) ...[
          const SizedBox(height: AnjizSpacing.md),
          trailing!,
        ],
      ],
    );
  }
}

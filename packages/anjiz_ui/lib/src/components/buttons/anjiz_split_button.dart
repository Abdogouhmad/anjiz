import 'package:flutter/material.dart';

import '../../services/anjiz_haptics.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// A split button: a primary action plus an attached dropdown arrow segment.
class AnjizSplitButton extends StatelessWidget {
  /// Creates a split button.
  const AnjizSplitButton({
    required this.label,
    this.onPressed,
    this.onArrowPressed,
    this.icon,
    this.arrowTooltip,
    super.key,
  });

  /// Primary action label.
  final String label;

  /// Primary action handler.
  final VoidCallback? onPressed;

  /// Dropdown arrow handler.
  final VoidCallback? onArrowPressed;

  /// Optional leading icon.
  final IconData? icon;

  /// Accessibility tooltip for the arrow segment.
  final String? arrowTooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: AnjizShapes.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onPressed == null
                  ? null
                  : () {
                      AnjizHaptics.tap();
                      onPressed!();
                    },
              borderRadius: AnjizShapes.pill,
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AnjizSpacing.lg,
                ),
                child: Row(
                  children: [
                    if (icon != null) ...[
                      Icon(icon, size: 20, color: scheme.onPrimary),
                      const SizedBox(width: AnjizSpacing.sm),
                    ],
                    Text(
                      label,
                      style: textTheme.labelLarge?.copyWith(
                        color: scheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 24,
            color: scheme.onPrimary.withValues(alpha: 0.3),
          ),
          IconButton(
            onPressed: onArrowPressed == null
                ? null
                : () {
                    AnjizHaptics.tap();
                    onArrowPressed!();
                  },
            tooltip: arrowTooltip,
            icon: Icon(Icons.arrow_drop_down_rounded, color: scheme.onPrimary),
          ),
        ],
      ),
    );
  }
}

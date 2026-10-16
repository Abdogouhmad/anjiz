import 'package:flutter/material.dart';

import '../../tokens/anjiz_elevation.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// The primary pill of the expanding floating action button.
///
/// Internal building block of `AnjizFabMenu`; compose that widget instead.
class AnjizFabPrimaryPill extends StatelessWidget {
  /// Creates a primary FAB pill.
  const AnjizFabPrimaryPill({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.scheme,
    super.key,
  });

  /// Visible action label.
  final String label;

  /// Leading action icon.
  final IconData icon;

  /// Tap handler.
  final VoidCallback onPressed;

  /// The resolved colour scheme.
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: AnjizShapes.card,
        boxShadow: AnjizElevation.floating(scheme.primary),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          borderRadius: AnjizShapes.card,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AnjizSpacing.md20,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: scheme.onPrimaryContainer),
                const SizedBox(width: AnjizSpacing.sm),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge
                      ?.copyWith(color: scheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

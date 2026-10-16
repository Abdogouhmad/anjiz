import 'package:flutter/material.dart';

import '../../tokens/anjiz_elevation.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import 'anjiz_fab_menu.dart';

/// One revealed secondary action: a labelled pill with a trailing icon button.
///
/// Internal building block of `AnjizFabMenu`; compose that widget instead.
class AnjizFabActionPill extends StatelessWidget {
  /// Creates an action pill for [action].
  const AnjizFabActionPill({
    required this.action,
    required this.onPressed,
    super.key,
  });

  /// The action being rendered.
  final AnjizFabAction action;

  /// Tap handler (usually collapses the menu before running the action).
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AnjizSpacing.md,
            vertical: AnjizSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: AnjizShapes.pill,
            boxShadow: AnjizElevation.floating(scheme.onSurface),
          ),
          child: Text(
            action.label,
            style: textTheme.labelLarge?.copyWith(color: scheme.onSurface),
          ),
        ),
        const SizedBox(width: AnjizSpacing.sm),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(action.icon, color: scheme.onSurface),
          ),
        ),
      ],
    );
  }
}

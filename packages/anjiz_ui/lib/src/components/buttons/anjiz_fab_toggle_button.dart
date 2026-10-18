import 'package:flutter/material.dart';

import '../../tokens/anjiz_motion.dart';
import '../../tokens/anjiz_shapes.dart';

/// The expand/collapse trigger beside an FAB menu's primary pill.
///
/// Internal building block of `AnjizFabMenu`; compose that widget instead.
class AnjizFabToggleButton extends StatelessWidget {
  /// Creates a toggle button.
  const AnjizFabToggleButton({
    required this.expanded,
    required this.rotation,
    required this.onPressed,
    this.tooltip,
    super.key,
  });

  /// Whether the menu is currently expanded.
  final bool expanded;

  /// Drives the icon rotation alongside the menu's expansion.
  final Animation<double> rotation;

  /// Tap handler.
  final VoidCallback onPressed;

  /// Accessibility tooltip.
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: AnjizShapes.card,
      ),
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: AnimatedRotation(
          turns: expanded ? 0.125 : 0,
          duration: AnjizMotion.fast,
          child: Icon(Icons.add_rounded, color: scheme.onSurface),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../tokens/anjiz_elevation.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// The primary surface container for Anjiz: a large (28dp) tonal card that
/// replaces heavy shadows with colour steps and an optional ambient bloom.
class AnjizCard extends StatelessWidget {
  /// Creates a tonal card.
  const AnjizCard({
    required this.child,
    this.padding = const EdgeInsets.all(AnjizSpacing.md),
    this.color,
    this.onTap,
    this.borderRadius,
    this.margin,
    this.elevated = false,
    super.key,
  });

  /// Card content.
  final Widget child;

  /// Inner padding.
  final EdgeInsetsGeometry padding;

  /// Overrides the default `surfaceContainerLowest` fill.
  final Color? color;

  /// Makes the whole card tappable when provided.
  final VoidCallback? onTap;

  /// Overrides the default 28dp radius.
  final BorderRadius? borderRadius;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  /// Adds the soft ambient bloom used for floating surfaces.
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = borderRadius ?? AnjizShapes.card;
    final decorated = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? scheme.surfaceContainerLowest,
        borderRadius: radius,
        boxShadow: elevated ? AnjizElevation.ambient(scheme.onSurface) : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
    return decorated;
  }
}

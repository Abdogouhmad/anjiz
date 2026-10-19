import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../tokens/anjiz_motion.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import 'anjiz_destination.dart';

/// The animated pill indicator and label for a navigation destination.
/// Internal building block of [AnjizNavDestinationTile]; not exported from
/// the barrel.
class AnjizNavDestinationIndicator extends StatefulWidget {
  /// Creates an animated destination indicator.
  const AnjizNavDestinationIndicator({
    required this.destination,
    required this.selected,
    super.key,
  });

  /// The destination to render.
  final AnjizDestination destination;

  /// Whether this destination is the active one.
  final bool selected;

  @override
  State<AnjizNavDestinationIndicator> createState() =>
      _AnjizNavDestinationIndicatorState();
}

class _AnjizNavDestinationIndicatorState
    extends State<AnjizNavDestinationIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    value: widget.selected ? 1 : 0,
    lowerBound: 0,
    upperBound: 1.2,
  );

  @override
  void didUpdateWidget(covariant AnjizNavDestinationIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      final target = widget.selected ? 1.0 : 0.0;
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = target.clamp(0.0, 1.2);
      } else {
        _controller.animateWith(
          SpringSimulation(
            AnjizMotion.spatialFast,
            _controller.value,
            target,
            0,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value.clamp(0.0, 1.0);
        final pillColor = Color.lerp(
          Colors.transparent,
          scheme.primaryContainer,
          t,
        );
        final iconColor = Color.lerp(
          scheme.onSurfaceVariant,
          scheme.onPrimaryContainer,
          t,
        );
        final labelColor = Color.lerp(
          scheme.onSurfaceVariant,
          scheme.onSurface,
          t,
        );
        final fontWeight = FontWeight.lerp(FontWeight.w500, FontWeight.w700, t);
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AnjizSpacing.md12,
                vertical: AnjizSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: pillColor,
                borderRadius: AnjizShapes.pill,
              ),
              child: Icon(
                widget.selected
                    ? widget.destination.selectedIcon
                    : widget.destination.icon,
                size: 22,
                color: iconColor,
              ),
            ),
            const SizedBox(height: AnjizSpacing.xs),
            Text(
              widget.destination.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: labelColor,
                fontWeight: fontWeight,
              ),
            ),
          ],
        );
      },
    );
  }
}

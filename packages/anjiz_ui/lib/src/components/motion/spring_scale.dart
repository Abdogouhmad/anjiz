import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../tokens/anjiz_motion.dart';

/// M3 Expressive building block: animates its child toward a target [scale]
/// with a spring whenever the target changes, honoring reduced motion.
class SpringScale extends StatefulWidget {
  /// Creates a spring-driven scale wrapper.
  const SpringScale({
    required this.child,
    this.scale = 1.0,
    this.alignment = AlignmentDirectional.center,
    this.spring,
    super.key,
  });

  /// The child to scale.
  final Widget child;

  /// Target scale.
  final double scale;

  /// Alignment of the scaled child.
  final AlignmentGeometry alignment;

  /// Spring to use when animating (defaults to [AnjizMotion.spatialFast]).
  final SpringDescription? spring;

  @override
  State<SpringScale> createState() => _SpringScaleState();
}

class _SpringScaleState extends State<SpringScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    value: widget.scale,
    lowerBound: -2,
    upperBound: 2,
  );

  @override
  void didUpdateWidget(covariant SpringScale oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scale != widget.scale) {
      final target = widget.scale;
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = target.clamp(-2, 2);
      } else {
        _controller.animateWith(
          SpringSimulation(
            widget.spring ?? AnjizMotion.spatialFast,
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        alignment: widget.alignment,
        scale: _controller.value,
        child: child,
      ),
      child: widget.child,
    );
  }
}

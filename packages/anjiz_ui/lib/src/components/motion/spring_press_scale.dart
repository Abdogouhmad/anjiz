import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../tokens/anjiz_motion.dart';

/// M3 Expressive building block: shrinks its child while pressed, springing
/// back on release; disabled when animations are reduced.
class SpringPressScale extends StatefulWidget {
  /// Creates a press-scale wrapper.
  const SpringPressScale({
    required this.child,
    this.pressedScale = 0.96,
    this.spring,
    super.key,
  });

  /// The child to scale.
  final Widget child;

  /// Scale applied while a pointer is down.
  final double pressedScale;

  /// Spring to use when animating back/releasing.
  final SpringDescription? spring;

  @override
  State<SpringPressScale> createState() => _SpringPressScaleState();
}

class _SpringPressScaleState extends State<SpringPressScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    value: 1,
    lowerBound: 0.5,
    upperBound: 1.2,
  );

  void _animateTo(double target) {
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = target.clamp(0.5, 1.2);
      return;
    }
    _controller.animateWith(
      SpringSimulation(
        widget.spring ?? AnjizMotion.spatialFast,
        _controller.value,
        target,
        0,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _animateTo(widget.pressedScale),
      onPointerUp: (_) => _animateTo(1.0),
      onPointerCancel: (_) => _animateTo(1.0),
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) =>
            Transform.scale(scale: _controller.value, child: child),
        child: widget.child,
      ),
    );
  }
}

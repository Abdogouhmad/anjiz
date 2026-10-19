import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../tokens/anjiz_motion.dart';

/// M3 Expressive building block: entrance animation with a slight overshoot.
class SpringIn extends StatefulWidget {
  /// Creates an entrance wrapper.
  const SpringIn({required this.child, this.spring, super.key});

  /// Child to animate in.
  final Widget child;

  /// Spring to use (defaults to [AnjizMotion.spatialStandard]).
  final SpringDescription? spring;

  @override
  State<SpringIn> createState() => _SpringInState();
}

class _SpringInState extends State<SpringIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    value: 0,
    lowerBound: 0,
    upperBound: 1.5,
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) {
      return;
    }
    _started = true;
    final disabled = MediaQuery.disableAnimationsOf(context);
    if (disabled) {
      _controller.value = 1;
      return;
    }
    _controller.animateWith(
      SpringSimulation(widget.spring ?? AnjizMotion.spatialStandard, 0, 1, 0),
    );
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
      builder: (context, child) => Opacity(
        opacity: _controller.value.clamp(0, 1),
        child: Transform.scale(
          scale: 0.94 + 0.06 * _controller.value,
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}

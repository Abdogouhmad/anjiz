import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../tokens/anjiz_motion.dart';

/// M3 Expressive building block: collapses or expands its [child] with a spring,
/// invoking [onCollapsed] once after the collapse spring settles.
class SpringCollapse extends StatefulWidget {
  /// Creates a collapsing/expanding wrapper.
  const SpringCollapse({
    required this.child,
    required this.collapsed,
    this.onCollapsed,
    this.spring,
    super.key,
  });

  /// The child to collapse/expand.
  final Widget child;

  /// Whether the child is collapsed.
  final bool collapsed;

  /// Called once after the spring settles when transitioning to collapsed.
  final VoidCallback? onCollapsed;

  /// Spring to use (defaults to [AnjizMotion.spatialStandard]).
  final SpringDescription? spring;

  @override
  State<SpringCollapse> createState() => _SpringCollapseState();
}

class _SpringCollapseState extends State<SpringCollapse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    value: widget.collapsed ? 0 : 1,
    // The spring is allowed to overshoot; [_progress] clamps it back into the
    // 0..1 range the size and fade transitions can render.
    lowerBound: 0,
    upperBound: 1.2,
  );
  late final Animation<double> _progress = _controller.drive(_ClampedTween());
  bool _notifiedCollapsed = false;

  @override
  void didUpdateWidget(covariant SpringCollapse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.collapsed == widget.collapsed) return;
    _notifiedCollapsed = !widget.collapsed;
    _animate(to: widget.collapsed ? 0.0 : 1.0);
  }

  void _animate({required double to}) {
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = to;
      _notifyIfSettled();
      return;
    }
    _controller
        .animateWith(
          SpringSimulation(
            widget.spring ?? AnjizMotion.spatialStandard,
            _controller.value,
            to,
            0,
          ),
        )
        .whenComplete(_notifyIfSettled);
  }

  void _notifyIfSettled() {
    if (!mounted || _notifiedCollapsed || !widget.collapsed) return;
    _notifiedCollapsed = true;
    widget.onCollapsed?.call();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _progress,
      alignment: AlignmentDirectional.topStart,
      child: FadeTransition(opacity: _progress, child: widget.child),
    );
  }
}

/// Maps the controller's overshooting range onto a renderable 0..1 progress.
class _ClampedTween extends Tween<double> {
  _ClampedTween() : super(begin: 0, end: 1);

  @override
  double transform(double t) => super.transform(t).clamp(0.0, 1.0);
}

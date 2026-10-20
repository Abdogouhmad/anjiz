import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../tokens/anjiz_motion.dart';

/// A check glyph that draws itself in with an expressive spring when [checked]
/// flips on, and clears instantly when it flips off.
///
/// Honors reduced motion: the stroke appears without animation, and the
/// entrance spring is skipped when the system disables animations.
class AnimatedCheck extends StatefulWidget {
  /// Creates an animated check glyph.
  const AnimatedCheck({
    required this.checked,
    this.size = 20,
    this.color,
    super.key,
  });

  /// Whether the check is shown.
  final bool checked;

  /// Edge length of the square the glyph is drawn in.
  final double size;

  /// Stroke colour; defaults to the theme's primary colour.
  final Color? color;

  @override
  State<AnimatedCheck> createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    value: widget.checked ? 1 : 0,
  );
  bool _entered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Draw-in on first build when already checked (e.g. a selected swatch),
    // skipped for reduced motion or disabled system animations.
    if (_entered || !widget.checked) return;
    _entered = true;
    if (AnjizMotion.reduced || MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
      return;
    }
    _controller
        .animateWith(SpringSimulation(AnjizMotion.expressive, 0, 1, 0))
        .whenComplete(() => _entered = false);
  }

  @override
  void didUpdateWidget(covariant AnimatedCheck oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.checked == widget.checked) return;
    if (AnjizMotion.reduced || MediaQuery.disableAnimationsOf(context)) {
      _controller.value = widget.checked ? 1 : 0;
      return;
    }
    _controller.animateWith(
      SpringSimulation(
        AnjizMotion.expressive,
        _controller.value,
        widget.checked ? 1 : 0,
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
    final color = widget.color ?? Theme.of(context).colorScheme.primary;
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          size: Size.square(widget.size),
          painter: _CheckPainter(progress: _controller.value, color: color),
        ),
      ),
    );
  }
}

/// Draws the check stroke progressively along its path as [progress] goes
/// from 0 (nothing) to 1 (full glyph).
class _CheckPainter extends CustomPainter {
  const _CheckPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.14
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.55)
      ..lineTo(size.width * 0.42, size.height * 0.75)
      ..lineTo(size.width * 0.8, size.height * 0.28);
    final metric = path.computeMetrics().single;
    final drawn = metric.extractPath(
      0,
      metric.length * progress.clamp(0.0, 1.0),
    );
    canvas.drawPath(drawn, paint);
  }

  @override
  bool shouldRepaint(_CheckPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

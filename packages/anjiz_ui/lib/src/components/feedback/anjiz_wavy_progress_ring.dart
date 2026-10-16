import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A circular progress ring whose stroke ripples in a continuous wave.
///
/// Optionally hosts [child] content (e.g. "3/5") in its centre.
class AnjizWavyProgressRing extends StatefulWidget {
  /// Creates a wavy ring progress indicator.
  const AnjizWavyProgressRing({
    required this.value,
    this.size = 72,
    this.strokeWidth = 8,
    this.animate = true,
    this.color,
    this.child,
    super.key,
  });

  /// Progress from 0.0 to 1.0.
  final double value;

  /// Diameter of the ring.
  final double size;

  /// Thickness of the ring stroke.
  final double strokeWidth;

  /// Whether the wave should continuously travel.
  final bool animate;

  /// Optional override for the progress color.
  final Color? color;

  /// Centered content.
  final Widget? child;

  @override
  State<AnjizWavyProgressRing> createState() => _AnjizWavyProgressRingState();
}

class _AnjizWavyProgressRingState extends State<AnjizWavyProgressRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  );

  @override
  void initState() {
    super.initState();
    if (widget.animate) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return SizedBox.square(
      dimension: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          painter: _WavyRingPainter(
            value: widget.value.clamp(0, 1),
            strokeWidth: widget.strokeWidth,
            phase: reduceMotion ? 0 : _controller.value * 2 * math.pi,
            progressColor: widget.color ?? scheme.primary,
            trackColor: scheme.surfaceContainerHighest,
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}

class _WavyRingPainter extends CustomPainter {
  _WavyRingPainter({
    required this.value,
    required this.strokeWidth,
    required this.phase,
    required this.progressColor,
    required this.trackColor,
  });

  final double value;
  final double strokeWidth;
  final double phase;
  final Color progressColor;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = trackColor,
    );
    if (value <= 0) return;
    final arc = _wavyArc(center, radius, value * 2 * math.pi);
    canvas.drawPath(
      arc,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..color = progressColor,
    );
  }

  Path _wavyArc(Offset center, double radius, double sweep) {
    const start = -math.pi / 2;
    final path = Path();
    final steps = math.max(24, (sweep * 40).round());
    for (var i = 0; i <= steps; i++) {
      final t = i / steps;
      final angle = start + t * sweep;
      final r = radius + 1.6 * math.sin(t * math.pi * 12 + phase);
      final point = center + Offset(r * math.cos(angle), r * math.sin(angle));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant _WavyRingPainter old) =>
      old.value != value ||
      old.phase != phase ||
      old.strokeWidth != strokeWidth ||
      old.progressColor != progressColor ||
      old.trackColor != trackColor;
}

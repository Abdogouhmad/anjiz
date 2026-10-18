import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A linear progress indicator whose fill is a continuous sine wave, as
/// specified by the Anjiz expressive design system.
class AnjizWavyProgress extends StatefulWidget {
  /// Creates a wavy linear progress indicator.
  const AnjizWavyProgress({
    required this.value,
    this.height = 14,
    this.animate = true,
    this.color,
    super.key,
  });

  /// Progress from 0.0 to 1.0.
  final double value;

  /// Height of the wavy track.
  final double height;

  /// Whether the wave should continuously scroll.
  final bool animate;

  /// Optional override for the progress color.
  final Color? color;

  @override
  State<AnjizWavyProgress> createState() => _AnjizWavyProgressState();
}

class _AnjizWavyProgressState extends State<AnjizWavyProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  );

  @override
  void initState() {
    super.initState();
    if (widget.animate) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant AnjizWavyProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
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
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => CustomPaint(
          painter: _WavyLinearPainter(
            value: widget.value.clamp(0, 1),
            phase: reduceMotion ? 0 : _controller.value * 2 * math.pi,
            progressColor: widget.color ?? scheme.primary,
            trackColor: scheme.surfaceContainerHighest,
          ),
        ),
      ),
    );
  }
}

class _WavyLinearPainter extends CustomPainter {
  _WavyLinearPainter({
    required this.value,
    required this.phase,
    required this.progressColor,
    required this.trackColor,
  });

  final double value;
  final double phase;
  final Color progressColor;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;
    final finalPath = _wavePath(size.width, centerY, phase);
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..color = trackColor;
    canvas.drawPath(finalPath, trackPaint);

    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width * value, size.height));
    canvas.drawPath(
      _wavePath(size.width, centerY, phase),
      Paint.from(trackPaint)..color = progressColor,
    );
    canvas.restore();
  }

  Path _wavePath(double width, double centerY, double phase) {
    const wavelength = 26.0;
    const amplitude = 3.0;
    final path = Path()..moveTo(0, centerY);
    for (var x = 0.0; x <= width; x += 2) {
      final y =
          centerY +
          amplitude * math.sin((x / wavelength) * 2 * math.pi + phase);
      path.lineTo(x, y);
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant _WavyLinearPainter old) =>
      old.value != value ||
      old.phase != phase ||
      old.progressColor != progressColor ||
      old.trackColor != trackColor;
}

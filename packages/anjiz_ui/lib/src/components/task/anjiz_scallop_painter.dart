import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Paints the scalloped "cookie" ring, its fill and the animated checkmark.
///
/// Internal building block of `AnjizTaskCheckbox`; [progress] drives the
/// circle → scallop + check morph (0 = plain ring, 1 = completed cookie).
/// Not exported from the package barrel.
class ScallopCheckPainter extends CustomPainter {
  /// Creates the painter.
  ScallopCheckPainter({
    required this.progress,
    required this.ringColor,
    required this.fillColor,
    required this.checkColor,
  });

  /// Morph progress from ring (0) to completed scallop (1).
  final double progress;

  /// Colour of the unfilled ring.
  final Color ringColor;

  /// Fill colour behind the check.
  final Color fillColor;

  /// Checkmark colour.
  final Color checkColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final baseRadius = size.shortestSide / 2 - 2;
    final amplitude = 0.14 * Curves.easeOut.transform(progress);

    final scallop = _scallopPath(center, baseRadius, amplitude, 8);
    if (progress > 0) {
      canvas.drawPath(
        scallop,
        Paint()..color = fillColor.withValues(alpha: progress.clamp(0, 1)),
      );
    }
    canvas.drawPath(
      scallop,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Color.lerp(ringColor, fillColor, progress)!,
    );

    if (progress > 0.15) {
      final checkProgress = ((progress - 0.15) / 0.85).clamp(0.0, 1.0);
      _paintCheck(canvas, size, checkProgress);
    }
  }

  void _paintCheck(Canvas canvas, Size size, double t) {
    final path = Path()
      ..moveTo(size.width * 0.28, size.height * 0.52)
      ..lineTo(size.width * 0.44, size.height * 0.67)
      ..lineTo(size.width * 0.73, size.height * 0.33);
    final metrics = path.computeMetrics().toList();
    final drawn = Path();
    for (final metric in metrics) {
      drawn.addPath(metric.extractPath(0, metric.length * t), Offset.zero);
    }
    canvas.drawPath(
      drawn,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.shortestSide * 0.11
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = checkColor,
    );
  }

  Path _scallopPath(Offset center, double radius, double amplitude, int lobes) {
    final path = Path();
    const steps = 120;
    for (var i = 0; i <= steps; i++) {
      final angle = (i / steps) * 2 * math.pi;
      final r = radius * (1 + amplitude * math.cos(lobes * angle));
      final point = center + Offset(r * math.cos(angle), r * math.sin(angle));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    return path..close();
  }

  @override
  bool shouldRepaint(covariant ScallopCheckPainter old) =>
      old.progress != progress ||
      old.ringColor != ringColor ||
      old.fillColor != fillColor ||
      old.checkColor != checkColor;
}

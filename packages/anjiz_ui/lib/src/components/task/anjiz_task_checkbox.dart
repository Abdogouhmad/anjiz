import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../tokens/anjiz_motion.dart';

/// The Morphing Task Checkbox: an outlined ring that springs into an
/// expressive 8-lobed scalloped "cookie" burst with a checkmark when completed.
class AnjizTaskCheckbox extends StatefulWidget {
  /// Creates a scalloped task checkbox.
  const AnjizTaskCheckbox({
    required this.value,
    this.onChanged,
    this.size = 24,
    this.semanticLabel,
    super.key,
  });

  /// Whether the checkbox is checked (task complete).
  final bool value;

  /// Called when the user toggles the checkbox. When null the control is inert.
  final ValueChanged<bool>? onChanged;

  /// Outer diameter of the checkbox in logical pixels.
  final double size;

  /// Accessibility label describing the control.
  final String? semanticLabel;

  @override
  State<AnjizTaskCheckbox> createState() => _AnjizTaskCheckboxState();
}

class _AnjizTaskCheckboxState extends State<AnjizTaskCheckbox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    value: widget.value ? 1 : 0,
  );

  @override
  void didUpdateWidget(covariant AnjizTaskCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = widget.value ? 1 : 0;
      } else {
        _controller.animateWith(
          SpringSimulation(
            AnjizMotion.expressive,
            _controller.value,
            widget.value ? 1 : 0,
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

  void _handleTap() => widget.onChanged?.call(!widget.value);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: widget.semanticLabel,
      checked: widget.value,
      button: true,
      onTap: widget.onChanged == null ? null : _handleTap,
      child: SizedBox(
        width: 48,
        height: 48,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onChanged == null ? null : _handleTap,
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => CustomPaint(
                size: Size.square(widget.size),
                painter: _ScallopCheckPainter(
                  progress: _controller.value,
                  ringColor: scheme.outline,
                  fillColor: scheme.primary,
                  checkColor: scheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScallopCheckPainter extends CustomPainter {
  _ScallopCheckPainter({
    required this.progress,
    required this.ringColor,
    required this.fillColor,
    required this.checkColor,
  });

  final double progress;
  final Color ringColor;
  final Color fillColor;
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
  bool shouldRepaint(covariant _ScallopCheckPainter old) =>
      old.progress != progress ||
      old.ringColor != ringColor ||
      old.fillColor != fillColor ||
      old.checkColor != checkColor;
}

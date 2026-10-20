import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../services/anjiz_haptics.dart';
import '../../tokens/anjiz_motion.dart';
import 'anjiz_scallop_painter.dart';

/// The Morphing Task Checkbox: an outlined ring that springs into an
/// expressive 8-lobed scalloped "cookie" burst with a checkmark when completed.
///
/// Completing fires celebratory haptics; reopening fires a light tap.
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

  void _handleTap() {
    // Celebratory feedback when a task completes, a light tap when reopened.
    if (widget.value) {
      AnjizHaptics.tap();
    } else {
      AnjizHaptics.success();
    }
    widget.onChanged?.call(!widget.value);
  }

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
                painter: ScallopCheckPainter(
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

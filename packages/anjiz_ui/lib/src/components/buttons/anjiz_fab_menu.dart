import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import '../../services/anjiz_haptics.dart';
import '../../tokens/anjiz_motion.dart';
import '../../tokens/anjiz_spacing.dart';
import 'anjiz_fab_menu_actions.dart';
import 'anjiz_fab_primary_pill.dart';
import 'anjiz_fab_toggle_button.dart';

/// A secondary action revealed by the expanding [AnjizFabMenu].
typedef AnjizFabAction = ({
  String label,
  IconData icon,
  VoidCallback onPressed,
});

/// An expanding floating action button: a primary pill action with a spring
/// toggle that reveals labelled micro-action pills above it.
class AnjizFabMenu extends StatefulWidget {
  /// Creates an expanding FAB menu.
  const AnjizFabMenu({
    required this.label,
    this.icon = Icons.add_rounded,
    required this.onPressed,
    this.actions = const <AnjizFabAction>[],
    this.expandTooltip,
    this.collapseTooltip,
    super.key,
  });

  /// Primary action label.
  final String label;

  /// Primary action icon.
  final IconData icon;

  /// Primary action handler.
  final VoidCallback onPressed;

  /// Revealed secondary actions.
  final List<AnjizFabAction> actions;

  /// Accessibility tooltip when collapsed.
  final String? expandTooltip;

  /// Accessibility tooltip when expanded.
  final String? collapseTooltip;

  @override
  State<AnjizFabMenu> createState() => _AnjizFabMenuState();
}

class _AnjizFabMenuState extends State<AnjizFabMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AnjizMotion.standard,
    reverseDuration: AnjizMotion.fast,
  );

  bool _expanded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    AnjizHaptics.tap();
    setState(() => _expanded = !_expanded);
    final target = _expanded ? 1.0 : 0.0;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = target;
      return;
    }
    _controller.animateWith(
      SpringSimulation(
        AnjizMotion.spatialStandard,
        _controller.value,
        target,
        0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.actions.isNotEmpty)
          AnjizFabMenuActions(
            actions: widget.actions,
            expansion: _controller,
            onActionPressed: (action) {
              _toggle();
              action.onPressed();
            },
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnjizFabPrimaryPill(
              label: widget.label,
              icon: widget.icon,
              onPressed: () {
                AnjizHaptics.tap();
                widget.onPressed();
              },
              scheme: scheme,
            ),
            if (widget.actions.isNotEmpty) ...[
              const SizedBox(width: AnjizSpacing.sm),
              AnjizFabToggleButton(
                expanded: _expanded,
                rotation: _controller,
                onPressed: _toggle,
                tooltip: _expanded
                    ? widget.collapseTooltip
                    : widget.expandTooltip,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

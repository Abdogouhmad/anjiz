import 'package:flutter/material.dart';

import '../../services/anjiz_haptics.dart';
import '../../tokens/anjiz_motion.dart';
import '../../tokens/anjiz_spacing.dart';
import 'anjiz_fab_action_pill.dart';
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
  late final Animation<double> _expansion = CurvedAnimation(
    parent: _controller,
    curve: AnjizMotion.standardCurve,
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
    if (_expanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.actions.isNotEmpty)
          SizeTransition(
            sizeFactor: _expansion,
            alignment: AlignmentDirectional.bottomEnd,
            child: FadeTransition(
              opacity: _expansion,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final action in widget.actions)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AnjizSpacing.sm),
                      child: AnjizFabActionPill(
                        action: action,
                        onPressed: () {
                          _toggle();
                          action.onPressed();
                        },
                      ),
                    ),
                ],
              ),
            ),
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
                rotation: _expansion,
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

import 'package:flutter/material.dart';

import '../../tokens/anjiz_elevation.dart';
import '../../tokens/anjiz_motion.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

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
                      child: _ActionPill(
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
            _PrimaryPill(
              label: widget.label,
              icon: widget.icon,
              onPressed: widget.onPressed,
              scheme: scheme,
            ),
            if (widget.actions.isNotEmpty) ...[
              const SizedBox(width: AnjizSpacing.sm),
              _ToggleButton(
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

class _PrimaryPill extends StatelessWidget {
  const _PrimaryPill({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.scheme,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: AnjizShapes.card,
        boxShadow: AnjizElevation.floating(scheme.primary),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          borderRadius: AnjizShapes.card,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AnjizSpacing.md20,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: scheme.onPrimaryContainer),
                const SizedBox(width: AnjizSpacing.sm),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge
                      ?.copyWith(color: scheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.expanded,
    required this.rotation,
    required this.onPressed,
    this.tooltip,
  });

  final bool expanded;
  final Animation<double> rotation;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: AnjizShapes.card,
      ),
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: AnimatedRotation(
          turns: expanded ? 0.125 : 0,
          duration: AnjizMotion.fast,
          child: Icon(Icons.add_rounded, color: scheme.onSurface),
        ),
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({required this.action, required this.onPressed});

  final AnjizFabAction action;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AnjizSpacing.md,
            vertical: AnjizSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: AnjizShapes.pill,
            boxShadow: AnjizElevation.floating(scheme.onSurface),
          ),
          child: Text(
            action.label,
            style: textTheme.labelLarge?.copyWith(color: scheme.onSurface),
          ),
        ),
        const SizedBox(width: AnjizSpacing.sm),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(action.icon, color: scheme.onSurface),
          ),
        ),
      ],
    );
  }
}

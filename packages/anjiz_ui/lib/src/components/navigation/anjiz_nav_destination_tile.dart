import 'package:flutter/material.dart';

import '../../tokens/anjiz_motion.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import 'anjiz_destination.dart';

/// A single tappable destination inside [AnjizFloatingNavBar]: an icon with an
/// animated pill indicator and a label beneath it.
class AnjizNavDestinationTile extends StatelessWidget {
  /// Creates a navigation destination tile.
  const AnjizNavDestinationTile({
    required this.destination,
    required this.selected,
    required this.onTap,
    super.key,
  });

  /// The destination to render.
  final AnjizDestination destination;

  /// Whether this destination is the active one.
  final bool selected;

  /// Called when the tile is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : AnjizMotion.fast;
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: destination.label,
        // The icon and label are decorative; the node's own label is announced.
        excludeSemantics: true,
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: duration,
                curve: AnjizMotion.standardCurve,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AnjizSpacing.md12,
                  vertical: AnjizSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? scheme.primaryContainer
                      : Colors.transparent,
                  borderRadius: AnjizShapes.pill,
                ),
                child: Icon(
                  selected ? destination.selectedIcon : destination.icon,
                  size: 22,
                  color: selected
                      ? scheme.onPrimaryContainer
                      : scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AnjizSpacing.xs),
              Text(
                destination.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall?.copyWith(
                  color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

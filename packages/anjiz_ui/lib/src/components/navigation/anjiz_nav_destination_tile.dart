import 'package:flutter/material.dart';

import '../../services/anjiz_haptics.dart';
import 'anjiz_destination.dart';
import 'anjiz_nav_destination_indicator.dart';

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
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: destination.label,
        // The icon and label are decorative; the node's own label is announced.
        excludeSemantics: true,
        child: InkWell(
          onTap: () {
            AnjizHaptics.selection();
            onTap();
          },
          customBorder: const StadiumBorder(),
          child: AnjizNavDestinationIndicator(
            destination: destination,
            selected: selected,
          ),
        ),
      ),
    );
  }
}

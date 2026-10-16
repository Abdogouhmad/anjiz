import 'package:flutter/material.dart';

import 'anjiz_destination.dart';

/// The medium/expanded (rail) navigation for >=600dp layouts.
class AnjizNavRail extends StatelessWidget {
  /// Creates a navigation rail.
  const AnjizNavRail({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    this.extended = false,
    this.leading,
    super.key,
  });

  /// Destinations to render.
  final List<AnjizDestination> destinations;

  /// Currently selected index.
  final int currentIndex;

  /// Selection callback.
  final ValueChanged<int> onDestinationSelected;

  /// Whether the rail is extended (labels always visible).
  final bool extended;

  /// Optional leading widget (e.g. a brand mark).
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      extended: extended,
      labelType: extended
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      leading: leading,
      destinations: [
        for (final destination in destinations)
          NavigationRailDestination(
            icon: Icon(destination.icon),
            selectedIcon: Icon(destination.selectedIcon),
            label: Text(destination.label),
          ),
      ],
    );
  }
}

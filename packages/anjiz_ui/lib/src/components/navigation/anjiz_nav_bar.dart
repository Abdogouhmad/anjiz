import 'package:flutter/material.dart';

import 'anjiz_destination.dart';

/// The compact (bottom) navigation bar for <600dp layouts, using pill-shaped
/// active indicators.
class AnjizNavBar extends StatelessWidget {
  /// Creates a navigation bar.
  const AnjizNavBar({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });

  /// Destinations to render.
  final List<AnjizDestination> destinations;

  /// Currently selected index.
  final int currentIndex;

  /// Selection callback.
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        for (final destination in destinations)
          NavigationDestination(
            icon: Icon(destination.icon),
            selectedIcon: Icon(destination.selectedIcon),
            label: destination.label,
          ),
      ],
    );
  }
}

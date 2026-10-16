import 'package:flutter/material.dart';

import '../components/navigation/anjiz_destination.dart';
import '../components/navigation/anjiz_floating_nav_bar.dart';
import '../components/navigation/anjiz_nav_rail.dart';
import 'anjiz_breakpoints.dart';

/// A responsive shell that swaps between a bottom navigation bar (compact) and
/// a navigation rail (medium/expanded).
class AnjizAdaptiveScaffold extends StatelessWidget {
  /// Creates an adaptive scaffold.
  const AnjizAdaptiveScaffold({
    required this.body,
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    this.floatingActionButton,
    this.railLeading,
    super.key,
  });

  /// The main content.
  final Widget body;

  /// Navigation destinations.
  final List<AnjizDestination> destinations;

  /// Currently selected destination index.
  final int currentIndex;

  /// Selection callback.
  final ValueChanged<int> onDestinationSelected;

  /// Optional floating action button (compact layouts only).
  final Widget? floatingActionButton;

  /// Optional rail leading widget.
  final Widget? railLeading;

  @override
  Widget build(BuildContext context) {
    final size = AnjizBreakpoints.of(context);
    if (size == AnjizWindowSize.compact) {
      return Scaffold(
        // Let content scroll behind the translucent glass bar.
        extendBody: true,
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: AnjizFloatingNavBar(
          destinations: destinations,
          currentIndex: currentIndex,
          onDestinationSelected: onDestinationSelected,
        ),
      );
    }
    return Scaffold(
      body: Row(
        children: [
          AnjizNavRail(
            destinations: destinations,
            currentIndex: currentIndex,
            onDestinationSelected: onDestinationSelected,
            extended: size == AnjizWindowSize.expanded,
            leading: railLeading,
          ),
          const VerticalDivider(width: 1),
          Expanded(child: body),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}

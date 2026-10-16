import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import 'anjiz_destination.dart';
import 'anjiz_nav_destination_tile.dart';

/// A floating, backdrop-blurred bottom navigation bar for compact layouts.
///
/// Instead of an opaque strip pinned to the edge, the destinations sit on a
/// translucent glass pill that hovers over the content. Use it with
/// `Scaffold.extendBody: true` so content scrolls behind it, and add
/// [contentBottomInset] to scrollables so the last item can clear it.
class AnjizFloatingNavBar extends StatelessWidget {
  /// Creates a floating navigation bar.
  const AnjizFloatingNavBar({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    this.blurSigma = 24,
    super.key,
  });

  /// Destinations to render.
  final List<AnjizDestination> destinations;

  /// Currently selected index.
  final int currentIndex;

  /// Selection callback.
  final ValueChanged<int> onDestinationSelected;

  /// Backdrop blur radius; larger is frostier.
  final double blurSigma;

  /// Height of the floating glass pill.
  static const double height = 64;

  /// Extra bottom padding a scrollable should leave so its last item can be
  /// scrolled clear of the floating bar.
  static const double contentBottomInset = height + AnjizSpacing.lg;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        AnjizSpacing.md,
        0,
        AnjizSpacing.md,
        AnjizSpacing.md12 + bottomInset,
      ),
      child: ClipRRect(
        borderRadius: AnjizShapes.pill,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.surfaceContainer.withValues(alpha: 0.72),
              borderRadius: AnjizShapes.pill,
              border: Border.all(
                color: scheme.outlineVariant.withValues(alpha: 0.45),
              ),
            ),
            child: SizedBox(
              height: height,
              child: Row(
                children: [
                  for (var i = 0; i < destinations.length; i++)
                    AnjizNavDestinationTile(
                      destination: destinations[i],
                      selected: i == currentIndex,
                      onTap: () => onDestinationSelected(i),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

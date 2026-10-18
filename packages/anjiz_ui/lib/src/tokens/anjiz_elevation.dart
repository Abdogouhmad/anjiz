import 'package:flutter/widgets.dart';

/// Elevation tokens. Anjiz follows M3 Expressive's tonal-step philosophy:
/// depth comes from surface colour steps, with only subtle ambient blooms
/// layered on top for floating surfaces.
abstract final class AnjizElevation {
  /// Ambient bloom for floating cards and sheets.
  static List<BoxShadow> ambient(Color tint) => [
    BoxShadow(
      color: tint.withValues(alpha: 0.04),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  /// Bloom for active/dragged elements.
  static List<BoxShadow> lifted(Color tint) => [
    BoxShadow(
      color: tint.withValues(alpha: 0.12),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  /// Dual-layer elevation for floating toolbars and expanding FABs.
  static List<BoxShadow> floating(Color tint) => [
    BoxShadow(
      color: tint.withValues(alpha: 0.08),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  /// No elevation — resting tonal surfaces.
  static const List<BoxShadow> none = <BoxShadow>[];
}

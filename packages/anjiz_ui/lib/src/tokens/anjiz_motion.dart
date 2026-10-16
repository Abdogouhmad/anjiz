import 'package:flutter/material.dart';

/// Motion tokens: M3 Expressive spring physics plus matched durations and
/// easing curves. Spatial springs drive position/size changes; effects springs
/// drive opacity, colour and shadow changes.
abstract final class AnjizMotion {
  /// Duration of a fast transition (small, local changes).
  static const Duration fast = Duration(milliseconds: 150);

  /// Duration of a default transition (most state changes).
  static const Duration standard = Duration(milliseconds: 300);

  /// Duration of a slow, expressive transition (container transforms).
  static const Duration slow = Duration(milliseconds: 500);

  /// Spring for small spatial movements (icon nudges, chips).
  static const SpringDescription spatialFast = SpringDescription(
    mass: 1,
    stiffness: 800,
    damping: 28,
  );

  /// Spring for standard spatial movements (list reorder, expand).
  static const SpringDescription spatialStandard = SpringDescription(
    mass: 1,
    stiffness: 500,
    damping: 30,
  );

  /// Spring for large spatial movements (sheets, hero containers).
  static const SpringDescription spatialSlow = SpringDescription(
    mass: 1,
    stiffness: 300,
    damping: 30,
  );

  /// Snappy spring for effect transitions (colour, opacity).
  static const SpringDescription effectsFast = SpringDescription(
    mass: 1,
    stiffness: 1400,
    damping: 40,
  );

  /// Standard spring for effect transitions.
  static const SpringDescription effectsStandard = SpringDescription(
    mass: 1,
    stiffness: 1000,
    damping: 40,
  );

  /// Expressive overshooting spring used for celebratory morphs.
  static const SpringDescription expressive = SpringDescription(
    mass: 1,
    stiffness: 420,
    damping: 18,
  );

  /// Default curve for entrances and state changes.
  static const Curve standardCurve = Easing.emphasizedDecelerate;

  /// Curve for elements leaving the screen.
  static const Curve exitCurve = Easing.emphasizedAccelerate;

  /// Curve for continuous, looped motion (progress, shimmer).
  static const Curve continuousCurve = Easing.standard;
}

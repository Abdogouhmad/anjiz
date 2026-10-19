import 'package:flutter/material.dart';

/// Motion tokens: M3 Expressive spring physics plus matched durations and
/// easing curves. Spatial springs drive position/size changes; effects springs
/// drive opacity, colour and shadow changes.
///
/// Tokens resolve at read time: when [reduced] is set, durations collapse to
/// zero and springs become critically damped, so every consumer honors the
/// reduced-motion policy without extra checks.
abstract final class AnjizMotion {
  /// Whether expressive motion must be suppressed. The app pushes this on
  /// every build (its "Motion" setting plus the system animator scale) through
  /// [configureReducedMotion]; components only ever read the tokens below.
  static bool reduced = false;

  /// Applies the reduced-motion policy (`true` = stillness).
  static void configureReducedMotion({required bool reducedMotion}) =>
      reduced = reducedMotion;

  /// Critically-damped spring used wherever motion is reduced: reaches the
  /// target quickly without a single overshoot.
  static const SpringDescription settled = SpringDescription(
    mass: 1,
    stiffness: 1000,
    damping: 60, // critical damping: damping = 2*sqrt(stiffness*mass)
  );

  static const Duration _fast = Duration(milliseconds: 150);
  static const Duration _standard = Duration(milliseconds: 300);
  static const Duration _slow = Duration(milliseconds: 500);

  static const SpringDescription _spatialFast = SpringDescription(
    mass: 1,
    stiffness: 800,
    damping: 28,
  );
  static const SpringDescription _spatialStandard = SpringDescription(
    mass: 1,
    stiffness: 500,
    damping: 30,
  );
  static const SpringDescription _spatialSlow = SpringDescription(
    mass: 1,
    stiffness: 300,
    damping: 30,
  );
  static const SpringDescription _effectsFast = SpringDescription(
    mass: 1,
    stiffness: 1400,
    damping: 40,
  );
  static const SpringDescription _effectsStandard = SpringDescription(
    mass: 1,
    stiffness: 1000,
    damping: 40,
  );
  static const SpringDescription _expressive = SpringDescription(
    mass: 1,
    stiffness: 420,
    damping: 18,
  );

  /// Duration of a fast transition (small, local changes); instant when
  /// motion is reduced.
  static Duration get fast => reduced ? Duration.zero : _fast;

  /// Duration of a default transition (most state changes); instant when
  /// motion is reduced.
  static Duration get standard => reduced ? Duration.zero : _standard;

  /// Duration of a slow, expressive transition (container transforms);
  /// shortened to [fast] when motion is reduced.
  static Duration get slow => reduced ? _fast : _slow;

  /// Spring for small spatial movements (icon nudges, chips).
  static SpringDescription get spatialFast => reduced ? settled : _spatialFast;

  /// Spring for standard spatial movements (list reorder, expand).
  static SpringDescription get spatialStandard =>
      reduced ? settled : _spatialStandard;

  /// Spring for large spatial movements (sheets, hero containers).
  static SpringDescription get spatialSlow => reduced ? settled : _spatialSlow;

  /// Snappy spring for effect transitions (colour, opacity).
  static SpringDescription get effectsFast => reduced ? settled : _effectsFast;

  /// Standard spring for effect transitions.
  static SpringDescription get effectsStandard =>
      reduced ? settled : _effectsStandard;

  /// Expressive overshooting spring used for celebratory morphs; settled when
  /// motion is reduced.
  static SpringDescription get expressive => reduced ? settled : _expressive;

  /// Default curve for entrances and state changes.
  static const Curve standardCurve = Easing.emphasizedDecelerate;

  /// Curve for elements leaving the screen.
  static const Curve exitCurve = Easing.emphasizedAccelerate;

  /// Curve for continuous, looped motion (progress, shimmer).
  static const Curve continuousCurve = Easing.standard;
}

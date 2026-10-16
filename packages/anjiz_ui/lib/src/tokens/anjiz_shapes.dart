import 'package:flutter/widgets.dart';

/// Corner-radius tokens for Anjiz's hyper-rounded, expressive geometry.
abstract final class AnjizShapes {
  /// 8dp — micro chips and inline tags.
  static const double extraSmall = 8;

  /// 12dp — context menus and nested subtask rows.
  static const double small = 12;

  /// 16dp — inputs and compact containers.
  static const double medium = 16;

  /// 20dp — media thumbnails and floating pills.
  static const double large = 20;

  /// 28dp — task cards, sheets and modal containers.
  static const double extraLarge = 28;

  /// 32dp — hero containers and celebratory surfaces.
  static const double huge = 32;

  /// Fully rounded pill (used for buttons, chips, nav indicators).
  static const double full = 999;

  /// Radius used for task cards and bottom sheets.
  static const BorderRadius card = BorderRadius.all(
    Radius.circular(extraLarge),
  );

  /// Radius used for pills and small chips.
  static const BorderRadius pill = BorderRadius.all(Radius.circular(full));

  /// Radius used for text fields, search bars and inputs.
  static const BorderRadius input = BorderRadius.all(Radius.circular(full));

  /// Radius used for nested/subtask surfaces.
  static const BorderRadius nested = BorderRadius.all(Radius.circular(small));

  /// Continuous shape helper so every surface shares the same silhouette.
  static ShapeBorder get cardShape =>
      const RoundedRectangleBorder(borderRadius: card);
}

import 'package:flutter/material.dart';

/// Convenience accessors for theme data and localisation.
extension BuildContextX on BuildContext {
  /// The active [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// The active [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Whether the current text direction is right-to-left.
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}

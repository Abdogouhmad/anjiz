import 'package:flutter/material.dart';

/// Semantic colour tones shared by badges, pills, chips and icon badges.
enum AnjizTone {
  /// Muted default for passive metadata.
  neutral,

  /// Emerald emphasis for interactive/selected states.
  primary,

  /// Sage emphasis for supporting context.
  secondary,

  /// Honey emphasis for time-sensitive or delightful cues.
  tertiary,

  /// Error emphasis.
  error,
}

/// Resolves an [AnjizTone] against the active [ColorScheme].
extension AnjizToneResolver on AnjizTone {
  /// Returns the container/on-container colour pair for this tone.
  ({Color container, Color onContainer}) resolve(ColorScheme scheme) {
    return switch (this) {
      AnjizTone.neutral => (
        container: scheme.surfaceContainer,
        onContainer: scheme.onSurfaceVariant,
      ),
      AnjizTone.primary => (
        container: scheme.primaryContainer,
        onContainer: scheme.onPrimaryContainer,
      ),
      AnjizTone.secondary => (
        container: scheme.secondaryContainer,
        onContainer: scheme.onSecondaryContainer,
      ),
      AnjizTone.tertiary => (
        container: scheme.tertiaryFixed,
        onContainer: scheme.onTertiaryFixed,
      ),
      AnjizTone.error => (
        container: scheme.errorContainer,
        onContainer: scheme.onErrorContainer,
      ),
    };
  }
}

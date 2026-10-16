import 'package:flutter/services.dart';

/// Centralises haptic feedback for user actions according to the persisted
/// haptic level setting (0: Off, 1: Subtle, 2: Expressive).
abstract final class AnjizHaptics {
  /// Triggers standard completion or toggle tactile feedback.
  static Future<void> trigger(int level) async {
    switch (level) {
      case 1:
        await HapticFeedback.lightImpact();
      case 2:
        await HapticFeedback.mediumImpact();
      default:
        break;
    }
  }

  /// Triggers celebratory or burst feedback on task completion.
  static Future<void> burst(int level) async {
    switch (level) {
      case 1:
        await HapticFeedback.lightImpact();
      case 2:
        await HapticFeedback.heavyImpact();
      default:
        break;
    }
  }

  /// Triggers a subtle selection click when choosing items or sliding.
  static Future<void> selection(int level) async {
    if (level > 0) {
      await HapticFeedback.selectionClick();
    }
  }
}

import 'package:flutter/services.dart';

/// Centralised, level-aware haptic feedback for every Anjiz component.
///
/// The app configures the intensity once at startup — and whenever the
/// "Motion & haptics" setting changes — through [configure]; components then
/// call the semantic methods directly so feedback stays consistent without
/// each widget knowing the setting. All calls are no-ops at level 0.
abstract final class AnjizHaptics {
  /// Matches the default haptic setting (expressive).
  static int _level = 2;

  /// Sets the intensity: 0 off, 1 subtle, 2 expressive.
  static void configure(int level) => _level = level.clamp(0, 2);

  /// Current intensity (0–2).
  static int get level => _level;

  /// Light tap for buttons, FABs and swipe actions.
  static Future<void> tap() async {
    if (_level > 0) await HapticFeedback.lightImpact();
  }

  /// Selection click for switches, chips and navigation items.
  static Future<void> selection() async {
    if (_level > 0) await HapticFeedback.selectionClick();
  }

  /// Celebratory feedback on task completion.
  static Future<void> success() async {
    if (_level == 2) {
      await HapticFeedback.heavyImpact();
    } else if (_level == 1) {
      await HapticFeedback.lightImpact();
    }
  }

  /// Attention feedback for warnings and destructive confirmations.
  static Future<void> warning() async {
    if (_level == 2) {
      await HapticFeedback.mediumImpact();
    } else if (_level == 1) {
      await HapticFeedback.lightImpact();
    }
  }

  /// Strong feedback for long press and reorder start.
  static Future<void> heavy() async {
    if (_level == 2) {
      await HapticFeedback.heavyImpact();
    } else if (_level == 1) {
      await HapticFeedback.mediumImpact();
    }
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';

/// App-level motion policy: the single place where Anjiz decides whether
/// expressive motion is allowed, forwarded to the [AnjizMotion] tokens that
/// every shared component reads.
///
/// Synced on every build in `app.dart` from the "Motion" setting and the
/// system animator scale, so components never read settings themselves.
abstract final class MotionTokens {
  /// Whether expressive motion must be suppressed; mirrors
  /// [AnjizMotion.reduced].
  static bool get reduced => AnjizMotion.reduced;

  /// Applies the app's motion policy (`true` = user turned motion off, or the
  /// system animator scale asks for stillness).
  static void configureReducedMotion({required bool reduced}) =>
      AnjizMotion.configureReducedMotion(reducedMotion: reduced);
}

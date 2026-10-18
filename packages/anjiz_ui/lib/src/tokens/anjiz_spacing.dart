/// Spacing scale for Anjiz, aligned to the 8dp baseline grid with a 4dp step.
abstract final class AnjizSpacing {
  /// 4dp — inline icon/label alignment.
  static const double xs = 4;

  /// 8dp — tight gaps between metadata badges.
  static const double sm = 8;

  /// 12dp — compact internal padding.
  static const double md12 = 12;

  /// 16dp — default padding and gutters.
  static const double md = 16;

  /// 20dp — roomy internal padding.
  static const double md20 = 20;

  /// 24dp — section spacing, tablet gutters.
  static const double lg = 24;

  /// 32dp — large vertical rhythm.
  static const double xl = 32;

  /// 48dp — desktop margins.
  static const double xxl = 48;

  /// Compact-screen horizontal page margin (<600dp).
  static const double margin = 16;

  /// Medium-screen (600–839dp) page margin.
  static const double marginTablet = 24;

  /// Expanded-screen (>=840dp) page margin.
  static const double marginDesktop = 48;

  /// Continuous-corner radius reuse for list grouping.
  static const double gutter = 16;

  /// Maximum content width on expanded layouts.
  static const double maxContentWidth = 1200;
}

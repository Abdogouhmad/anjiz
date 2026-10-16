import 'package:flutter/widgets.dart';

import '../tokens/anjiz_spacing.dart';

/// Window-size classes used for adaptive layouts.
enum AnjizWindowSize {
  /// Phones and small foldables (<600dp).
  compact,

  /// Tablets and large foldables (600–839dp).
  medium,

  /// Desktops and large tablets (>=840dp).
  expanded,
}

/// Breakpoint helpers for Anjiz adaptive layouts.
abstract final class AnjizBreakpoints {
  /// Lower bound of the medium window class.
  static const double medium = 600;

  /// Lower bound of the expanded window class.
  static const double expanded = 840;

  /// Resolves the current window-size class from [context].
  static AnjizWindowSize of(BuildContext context) {
    return fromWidth(MediaQuery.sizeOf(context).width);
  }

  /// Resolves the window-size class for an explicit [width].
  static AnjizWindowSize fromWidth(double width) {
    if (width >= expanded) return AnjizWindowSize.expanded;
    if (width >= medium) return AnjizWindowSize.medium;
    return AnjizWindowSize.compact;
  }

  /// Whether a split list/detail layout should be shown for [width].
  static bool isTwoPane(double width) => width >= medium;

  /// The page margin for the given [size].
  static double margin(AnjizWindowSize size) => switch (size) {
    AnjizWindowSize.compact => AnjizSpacing.margin,
    AnjizWindowSize.medium => AnjizSpacing.marginTablet,
    AnjizWindowSize.expanded => AnjizSpacing.marginDesktop,
  };
}

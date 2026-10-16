import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import 'anjiz_color_schemes.dart';
import 'anjiz_theme.dart';

/// Builds the Anjiz light/dark themes and hands them to [builder].
///
/// Resolution order: an explicit [seedColor] wins (used by the accent-tone
/// setting), then Material You dynamic colour when [useDynamicColor] is on and
/// the platform supports it, and finally the built-in emerald fallback.
class AnjizDynamicTheme extends StatelessWidget {
  /// Creates a dynamic theme builder.
  const AnjizDynamicTheme({
    required this.builder,
    this.useDynamicColor = true,
    this.seedColor,
    super.key,
  });

  /// Receives the resolved light and dark themes.
  final Widget Function(
    BuildContext context,
    ThemeData lightTheme,
    ThemeData darkTheme,
  )
  builder;

  /// Whether to use the platform's Material You palette when available.
  final bool useDynamicColor;

  /// Optional seed colour that overrides dynamic colour entirely.
  final Color? seedColor;

  @override
  Widget build(BuildContext context) {
    final seed = seedColor;
    if (seed != null) {
      return builder(
        context,
        AnjizTheme.light(
          colorScheme: ColorScheme.fromSeed(
            seedColor: seed,
            brightness: Brightness.light,
          ),
        ),
        AnjizTheme.dark(
          colorScheme: ColorScheme.fromSeed(
            seedColor: seed,
            brightness: Brightness.dark,
          ),
        ),
      );
    }
    if (!useDynamicColor) {
      return builder(context, AnjizTheme.light(), AnjizTheme.dark());
    }
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => builder(
        context,
        AnjizTheme.light(
          colorScheme: lightDynamic ?? AnjizColorSchemes.light(),
        ),
        AnjizTheme.dark(colorScheme: darkDynamic ?? AnjizColorSchemes.dark()),
      ),
    );
  }
}

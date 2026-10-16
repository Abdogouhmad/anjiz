import 'package:flutter/material.dart';

/// Anjiz colour schemes. The fallback palette is grown from the emerald seed
/// `#1B7A66`; dynamic (Material You) schemes are layered on top at runtime.
abstract final class AnjizColorSchemes {
  /// Fallback seed colour when the platform does not expose a dynamic palette.
  static const Color seed = Color(0xFF1B7A66);

  /// Light scheme matching the Anjiz design tokens.
  static ColorScheme light() {
    return ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    ).copyWith(
      primary: const Color(0xFF00604F),
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFF1B7A66),
      onPrimaryContainer: const Color(0xFFAFFFE7),
      secondary: const Color(0xFF4C635B),
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFCCE5DB),
      onSecondaryContainer: const Color(0xFF50675F),
      tertiary: const Color(0xFF704E00),
      onTertiary: const Color(0xFFFFFFFF),
      tertiaryContainer: const Color(0xFF8B661B),
      onTertiaryContainer: const Color(0xFFFFEDD3),
      error: const Color(0xFFBA1A1A),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFFFDAD6),
      onErrorContainer: const Color(0xFF93000A),
      surface: const Color(0xFFF2FCF5),
      onSurface: const Color(0xFF141D1A),
      onSurfaceVariant: const Color(0xFF3E4945),
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFECF6F0),
      surfaceContainer: const Color(0xFFE6F0EA),
      surfaceContainerHigh: const Color(0xFFE0EBE4),
      surfaceContainerHighest: const Color(0xFFDBE5DF),
      outline: const Color(0xFF6E7A75),
      outlineVariant: const Color(0xFFBEC9C4),
      inverseSurface: const Color(0xFF29322E),
      onInverseSurface: const Color(0xFFE9F3ED),
      inversePrimary: const Color(0xFF81D6BF),
    );
  }

  /// Dark scheme matching the Anjiz design tokens.
  static ColorScheme dark() {
    return ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    ).copyWith(
      primary: const Color(0xFF87D6C1),
      onPrimary: const Color(0xFF00382C),
      primaryContainer: const Color(0xFF005142),
      onPrimaryContainer: const Color(0xFFA3F2DC),
      secondary: const Color(0xFFB3CCC2),
      onSecondary: const Color(0xFF1F3530),
      secondaryContainer: const Color(0xFF354B44),
      onSecondaryContainer: const Color(0xFFCFE8DE),
      tertiary: const Color(0xFFEEC06E),
      onTertiary: const Color(0xFF3D2E00),
      tertiaryContainer: const Color(0xFF5B4100),
      onTertiaryContainer: const Color(0xFFFFDEA9),
      error: const Color(0xFFFFB4AB),
      onError: const Color(0xFF690005),
      errorContainer: const Color(0xFF93000A),
      onErrorContainer: const Color(0xFFFFDAD6),
      surface: const Color(0xFF0F1513),
      onSurface: const Color(0xFFDFE4E0),
      onSurfaceVariant: const Color(0xFFBEC9C4),
      surfaceContainerLowest: const Color(0xFF0A0F0E),
      surfaceContainerLow: const Color(0xFF171D1B),
      surfaceContainer: const Color(0xFF1B211F),
      surfaceContainerHigh: const Color(0xFF212B28),
      surfaceContainerHighest: const Color(0xFF303634),
      outline: const Color(0xFF889390),
      outlineVariant: const Color(0xFF3E4945),
      inverseSurface: const Color(0xFFDFE4E0),
      onInverseSurface: const Color(0xFF29322E),
      inversePrimary: const Color(0xFF006B58),
    );
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('pure black dark theme collapses surfaces onto true black', () {
    final theme = AnjizTheme.dark(pureBlack: true);

    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.surface, const Color(0xFF000000));
    expect(theme.scaffoldBackgroundColor, const Color(0xFF000000));
    // Surface steps stay distinct so cards remain readable on black.
    expect(
      theme.colorScheme.surfaceContainer,
      isNot(theme.colorScheme.surface),
    );
  });

  test('pure black is ignored for light schemes', () {
    final base = AnjizColorSchemes.light();
    expect(AnjizColorSchemes.pureBlack(base), base);
  });

  test('the default dark theme keeps its tonal surfaces', () {
    final theme = AnjizTheme.dark();

    expect(theme.colorScheme.surface, isNot(const Color(0xFF000000)));
  });
}

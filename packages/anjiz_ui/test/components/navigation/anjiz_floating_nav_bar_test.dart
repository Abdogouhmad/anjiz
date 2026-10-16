import 'dart:ui' show ImageFilter;

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const destinations = <AnjizDestination>[
    (label: 'Today', icon: Icons.sunny, selectedIcon: Icons.sunny),
    (label: 'Lists', icon: Icons.list, selectedIcon: Icons.list),
  ];

  Future<void> pump(WidgetTester tester, ValueChanged<int> onSelected) {
    return tester.pumpWidget(
      MaterialApp(
        theme: AnjizTheme.dark(),
        home: Scaffold(
          extendBody: true,
          body: const SizedBox.expand(),
          bottomNavigationBar: AnjizFloatingNavBar(
            destinations: destinations,
            currentIndex: 0,
            onDestinationSelected: onSelected,
          ),
        ),
      ),
    );
  }

  testWidgets('renders on a blurred glass pill', (tester) async {
    await pump(tester, (_) {});

    expect(find.byType(BackdropFilter), findsOneWidget);
    final filter = tester
        .widget<BackdropFilter>(find.byType(BackdropFilter))
        .filter;
    expect(filter, isA<ImageFilter>());
  });

  testWidgets('reports the tapped destination', (tester) async {
    final taps = <int>[];
    await pump(tester, taps.add);

    await tester.tap(find.text('Lists'));
    await tester.pump();

    expect(taps, <int>[1]);
  });

  testWidgets('marks the active destination as selected for a11y', (
    tester,
  ) async {
    await pump(tester, (_) {});

    expect(
      tester.getSemantics(find.text('Today')),
      isSemantics(label: 'Today', isSelected: true, isButton: true),
    );
  });

  testWidgets('leaves room for content to clear the bar', (tester) async {
    await pump(tester, (_) {});

    expect(
      AnjizFloatingNavBar.contentBottomInset,
      greaterThan(AnjizFloatingNavBar.height),
    );
  });
}

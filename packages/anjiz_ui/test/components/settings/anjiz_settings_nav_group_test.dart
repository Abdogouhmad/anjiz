import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpGroup(
    WidgetTester tester,
    List<AnjizSettingsNavEntry> entries,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AnjizTheme.light(),
        home: Scaffold(
          body: SingleChildScrollView(
            child: AnjizSettingsNavGroup(entries: entries),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('renders one row per entry', (tester) async {
    await pumpGroup(tester, const [
      AnjizSettingsNavEntry(
        icon: Icons.tune_rounded,
        title: 'General',
        subtitle: 'Theme, motion and haptics',
        onTap: _noop,
      ),
      AnjizSettingsNavEntry(
        icon: Icons.info_outline_rounded,
        title: 'About',
        tone: AnjizTone.neutral,
        onTap: _noop,
      ),
    ]);

    expect(tester.takeException(), isNull);
    expect(find.text('General'), findsOneWidget);
    expect(find.text('Theme, motion and haptics'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.byIcon(Icons.tune_rounded), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right_rounded), findsNWidgets(2));
  });

  testWidgets('reports the tapped entry', (tester) async {
    final taps = <String>[];
    await pumpGroup(tester, [
      AnjizSettingsNavEntry(
        icon: Icons.tune_rounded,
        title: 'General',
        onTap: () => taps.add('general'),
      ),
      AnjizSettingsNavEntry(
        icon: Icons.info_outline_rounded,
        title: 'About',
        onTap: () => taps.add('about'),
      ),
    ]);

    await tester.tap(find.text('About'));
    await tester.pump();

    expect(taps, ['about']);
  });

  testWidgets('keeps its rows inside the card without overflowing', (
    tester,
  ) async {
    const group = AnjizSettingsNavGroup(
      entries: [
        AnjizSettingsNavEntry(
          icon: Icons.tune_rounded,
          title: 'General',
          subtitle: 'Theme, motion and haptics',
          onTap: _noop,
        ),
      ],
    );
    await tester.pumpWidget(
      MaterialApp(
        theme: AnjizTheme.light(),
        home: const Scaffold(
          body: SizedBox(
            width: 320,
            child: MediaQuery(
              data: MediaQueryData(textScaler: TextScaler.linear(2)),
              child: SingleChildScrollView(child: group),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}

void _noop() {}

import 'package:anjiz/features/lists/presentation/widgets/lists_stats_strip.dart';
import 'package:anjiz/l10n/app_localizations.dart';
import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Pumps the strip the way the Lists screen does: inside a sliver, so the
  /// strip's height is unbounded.
  Future<void> pumpInSliver(WidgetTester tester, {double textScale = 1}) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AnjizTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverList.list(
                  children: const [
                    ListsStatsStrip(
                      projects: 4,
                      activeTasks: 12,
                      weeklyVelocity: 0.73,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('lays out inside a sliver with unbounded height', (tester) async {
    await pumpInSliver(tester);

    expect(tester.takeException(), isNull);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('73%'), findsOneWidget);
  });

  testWidgets('gives every pill the height of the tallest one', (tester) async {
    await pumpInSliver(tester);

    final heights = [
      tester.getSize(find.text('4')).height,
      tester.getSize(find.text('12')).height,
      tester.getSize(find.text('73%')).height,
    ];
    expect(heights.toSet(), hasLength(1));
  });

  testWidgets('does not overflow at 2x text scale', (tester) async {
    await pumpInSliver(tester, textScale: 2);

    expect(tester.takeException(), isNull);
  });
}

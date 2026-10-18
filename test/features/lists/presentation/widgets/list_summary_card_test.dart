import 'package:anjiz/domain/entities/task_list.dart';
import 'package:anjiz/features/lists/presentation/providers/task_list_summary.dart';
import 'package:anjiz/features/lists/presentation/widgets/list_summary_card.dart';
import 'package:anjiz/l10n/app_localizations.dart';
import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final summary = TaskListSummary(
    list: TaskList(
      id: 'my-tasks',
      name: 'My Tasks',
      color: 0xFF1B7A66,
      icon: 'inbox',
      createdAt: DateTime(2026, 10, 16),
    ),
    remaining: 10,
    completed: 0,
  );

  /// Pumps the card at the width the two-column grid gives it on a 460dp
  /// screen ((460 - 2*16 margins - 12 gap) / 2), inside the same unbounded-height
  /// context as `ListsGrid`'s `Wrap`.
  Future<void> pumpAtGridWidth(
    WidgetTester tester, {
    double width = 208,
    double textScale = 1,
    bool featured = true,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AnjizTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Wrap(
                children: [
                  SizedBox(
                    width: width,
                    child: ListSummaryCard(
                      summary: summary,
                      featured: featured,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // The wavy progress indicator animates indefinitely, so settling is not an
    // option here.
    await tester.pump();
  }

  testWidgets('does not overflow a narrow grid column', (tester) async {
    await pumpAtGridWidth(tester);

    expect(tester.takeException(), isNull);
  });

  testWidgets('does not overflow the non-featured treatment', (tester) async {
    await pumpAtGridWidth(tester, featured: false);

    expect(tester.takeException(), isNull);
  });

  testWidgets('does not overflow at 2x text scale', (tester) async {
    await pumpAtGridWidth(tester, textScale: 2);

    expect(tester.takeException(), isNull);
  });

  testWidgets('reports the tap', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AnjizTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ListSummaryCard(summary: summary, onTap: () => taps++),
        ),
      ),
    );

    await tester.tap(find.byType(ListSummaryCard));
    await tester.pump();

    expect(taps, 1);
  });
}

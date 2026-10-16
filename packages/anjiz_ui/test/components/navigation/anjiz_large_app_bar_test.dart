import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Pumps a scrollable screen with a large collapsing app bar and collapses it.
  Future<void> pumpAndCollapse(
    WidgetTester tester, {
    double textScale = 1,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                const AnjizLargeAppBar(
                  title: 'Today',
                  subtitle: 'Friday, Oct 16',
                ),
                SliverList.list(
                  children: [
                    for (var i = 0; i < 40; i++)
                      const SizedBox(height: 48, child: Text('row')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // Scroll far enough that the flexible space is fully collapsed; this used to
    // overflow because title + subtitle are taller than the collapsed toolbar.
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -600));
    await tester.pumpAndSettle();
  }

  testWidgets('does not overflow when collapsed', (tester) async {
    await pumpAndCollapse(tester);
    expect(tester.takeException(), isNull);
  });

  testWidgets('does not overflow when collapsed at 2x text scale', (
    tester,
  ) async {
    await pumpAndCollapse(tester, textScale: 2);
    expect(tester.takeException(), isNull);
  });
}

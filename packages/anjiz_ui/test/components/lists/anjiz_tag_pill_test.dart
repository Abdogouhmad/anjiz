import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpPill(
    WidgetTester tester,
    Widget pill, {
    double hostWidth = 400,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AnjizTheme.dark(),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: hostWidth,
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  const SizedBox(width: AnjizSpacing.sm),
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: pill,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('sizes to its label when it has room', (tester) async {
    await pumpPill(tester, const AnjizTagPill(label: 'Due in 2h'));

    final size = tester.getSize(find.byType(AnjizTagPill));
    expect(tester.takeException(), isNull);
    expect(size.height, lessThan(30));
    expect(size.width, lessThan(180));
  });

  testWidgets('ellipsizes a long label in a narrow slot', (tester) async {
    await pumpPill(
      tester,
      const AnjizTagPill(label: '10 tasks remaining in this list'),
      hostWidth: 140,
    );

    expect(tester.takeException(), isNull);
    expect(tester.getSize(find.byType(AnjizTagPill)).height, lessThan(30));
  });

  testWidgets('ellipsizes next to a leading icon', (tester) async {
    await pumpPill(
      tester,
      const AnjizTagPill(
        label: '10 tasks remaining in this list',
        icon: Icons.star_rounded,
      ),
      hostWidth: 140,
    );

    expect(tester.takeException(), isNull);
    expect(tester.getSize(find.byType(AnjizTagPill)).height, lessThan(30));
    expect(find.byIcon(Icons.star_rounded), findsOneWidget);
  });
}

import 'dart:ui' show CheckedState;

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pump(WidgetTester tester, Widget child) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: Center(child: child)),
    ),
  );

  testWidgets('reports a completion toggle when tapped', (tester) async {
    final changes = <bool>[];
    await pump(tester, AnjizTaskCheckbox(value: false, onChanged: changes.add));

    await tester.tap(find.byType(AnjizTaskCheckbox));
    await tester.pump();

    expect(changes, <bool>[true]);
  });

  testWidgets('reports an un-completion toggle when already checked', (
    tester,
  ) async {
    final changes = <bool>[];
    await pump(tester, AnjizTaskCheckbox(value: true, onChanged: changes.add));

    await tester.tap(find.byType(AnjizTaskCheckbox));
    await tester.pump();

    expect(changes, <bool>[false]);
  });

  testWidgets('exposes a labelled checked semantics node', (tester) async {
    final handle = tester.ensureSemantics();
    await pump(
      tester,
      const AnjizTaskCheckbox(value: true, semanticLabel: 'Review brief'),
    );

    final node = tester.getSemantics(find.byType(AnjizTaskCheckbox));
    expect(node.flagsCollection.isChecked, CheckedState.isTrue);
    expect(node.label, 'Review brief');

    handle.dispose();
  });

  testWidgets('springs into the scalloped burst without throwing', (
    tester,
  ) async {
    await pump(tester, const AnjizTaskCheckbox(value: false));
    expect(find.byType(CustomPaint), findsWidgets);

    await pump(tester, const AnjizTaskCheckbox(value: true));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('jumps to the final state when animations are disabled', (
    tester,
  ) async {
    await pump(
      tester,
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: AnjizTaskCheckbox(value: true),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}

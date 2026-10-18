import 'package:anjiz/core/utils/task_format.dart';
import 'package:anjiz/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Resolves a [BuildContext] that has the app's localisations in scope.
  Future<BuildContext> pumpContext(WidgetTester tester) async {
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (inner) {
            context = inner;
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    return context;
  }

  final now = DateTime(2026, 10, 16, 17);

  testWidgets('countdowns carry no preposition of their own', (tester) async {
    final context = await pumpContext(tester);

    expect(
      TaskFormat.countdown(
        context,
        now.subtract(const Duration(hours: 8)),
        now,
      ),
      '8h',
    );
    expect(
      TaskFormat.countdown(
        context,
        now.subtract(const Duration(minutes: 30)),
        now,
      ),
      '30m',
    );
    expect(
      TaskFormat.countdown(context, now.subtract(const Duration(days: 3)), now),
      '3d',
    );
    expect(
      TaskFormat.countdown(context, now.add(const Duration(hours: 2)), now),
      '2h',
    );
  });

  testWidgets('countdowns ignore the sign of the difference', (tester) async {
    final context = await pumpContext(tester);

    expect(
      TaskFormat.countdown(
        context,
        now,
        now.subtract(const Duration(hours: 8)),
      ),
      '8h',
    );
    expect(
      TaskFormat.countdown(context, now, now.add(const Duration(hours: 8))),
      '8h',
    );
  });

  testWidgets('a task due seconds ago reads as a minute, never zero', (
    tester,
  ) async {
    final context = await pumpContext(tester);

    expect(
      TaskFormat.countdown(
        context,
        now.subtract(const Duration(seconds: 5)),
        now,
      ),
      '1m',
    );
  });

  testWidgets('the overdue pill reads "Overdue by 8h"', (tester) async {
    final context = await pumpContext(tester);
    final l10n = AppLocalizations.of(context);
    final due = now.subtract(const Duration(hours: 8));

    expect(
      l10n.labelOverdueBy(TaskFormat.countdown(context, now, due)),
      'Overdue by 8h',
    );
  });

  testWidgets('the future pill reads "Due in 2h"', (tester) async {
    final context = await pumpContext(tester);
    final l10n = AppLocalizations.of(context);
    final due = now.add(const Duration(hours: 2));

    expect(
      l10n.labelDueIn(TaskFormat.countdown(context, due, now)),
      'Due in 2h',
    );
  });

  testWidgets('dueLabel always keeps the real date, even when overdue', (
    tester,
  ) async {
    final context = await pumpContext(tester);

    expect(
      TaskFormat.dueLabel(context, now.subtract(const Duration(hours: 8)), now),
      'Today • 9:00 AM',
    );
    expect(
      TaskFormat.dueLabel(context, now.subtract(const Duration(days: 3)), now),
      'Tuesday, Oct 13 • 5:00 PM',
    );
  });

  testWidgets('dueLabel drops the time for date-only tasks', (tester) async {
    final context = await pumpContext(tester);

    expect(
      TaskFormat.dueLabel(
        context,
        now.subtract(const Duration(days: 3)),
        now,
        hasTime: false,
      ),
      'Tuesday, Oct 13',
    );
  });
}

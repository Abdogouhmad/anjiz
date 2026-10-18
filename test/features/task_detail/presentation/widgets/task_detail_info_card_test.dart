import 'package:anjiz/core/utils/task_format.dart';
import 'package:anjiz/domain/entities/task.dart';
import 'package:anjiz/features/task_detail/presentation/widgets/task_detail_info_card.dart';
import 'package:anjiz/l10n/app_localizations.dart';
import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Task task({DateTime? dueAt, bool hasTime = true}) => Task(
    id: 'seed-0',
    listId: 'my-tasks',
    title: 'Review mobile wireframes',
    dueAt: dueAt,
    hasTime: hasTime,
    createdAt: DateTime(2026, 10, 1),
    updatedAt: DateTime(2026, 10, 1),
  );

  Future<void> pumpCard(WidgetTester tester, Task value) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AnjizTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: TaskDetailInfoCard(
              task: value,
              listName: 'My Tasks',
              onEditDue: () {},
              onEditRecurrence: () {},
              onChangeList: () {},
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('keeps the real date in the row and the state in the pill', (
    tester,
  ) async {
    final due = DateTime.now().subtract(const Duration(hours: 8));
    await pumpCard(tester, task(dueAt: due));
    final context = tester.element(find.byType(TaskDetailInfoCard));

    expect(
      find.text(TaskFormat.dueLabel(context, due, DateTime.now())),
      findsOneWidget,
    );
    expect(find.text('Overdue by 8h'), findsOneWidget);
  });

  testWidgets('reads "Due in 2h" for a task that is still ahead', (
    tester,
  ) async {
    // Countdowns floor to the largest whole unit, so 2h30m away reads "2h".
    final due = DateTime.now().add(const Duration(hours: 2, minutes: 30));
    await pumpCard(tester, task(dueAt: due));

    expect(find.text('Due in 2h'), findsOneWidget);
  });

  testWidgets('says "No due date" and shows no pill without a date', (
    tester,
  ) async {
    await pumpCard(tester, task());

    expect(find.text('No due date'), findsOneWidget);
    expect(find.textContaining('Overdue'), findsNothing);
    expect(find.textContaining('Due in'), findsNothing);
  });

  testWidgets('drops the clock for a date-only task', (tester) async {
    final due = DateTime.now().add(const Duration(days: 1));
    await pumpCard(tester, task(dueAt: due, hasTime: false));

    expect(find.text('Tomorrow'), findsOneWidget);
  });
}

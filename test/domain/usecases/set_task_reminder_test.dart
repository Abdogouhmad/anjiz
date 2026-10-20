import 'package:anjiz/core/utils/id_generator.dart';
import 'package:anjiz/domain/entities/reminder.dart';
import 'package:anjiz/domain/repositories/reminder_repository.dart';
import 'package:anjiz/domain/services/reminder_scheduler.dart';
import 'package:anjiz/domain/usecases/set_task_reminder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../support/fixtures.dart';

class _MockReminderRepository extends Mock implements ReminderRepository {}

class _MockReminderScheduler extends Mock implements ReminderScheduler {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      Reminder(
        id: 'fallback',
        taskId: 'task-1',
        remindAt: DateTime(2026, 10, 16),
        notificationId: 1,
      ),
    );
  });

  late _MockReminderRepository reminders;
  late _MockReminderScheduler scheduler;
  late SetTaskReminder useCase;

  setUp(() {
    reminders = _MockReminderRepository();
    scheduler = _MockReminderScheduler();
    useCase = SetTaskReminder(reminders: reminders, scheduler: scheduler);
    when(() => reminders.deleteForTask(any())).thenAnswer((_) async {});
    when(() => reminders.upsert(any())).thenAnswer((_) async {});
    when(() => scheduler.cancel(any())).thenAnswer((_) async {});
    when(
      () => scheduler.schedule(
        id: any(named: 'id'),
        title: any(named: 'title'),
        body: any(named: 'body'),
        at: any(named: 'at'),
      ),
    ).thenAnswer((_) async {});
  });

  test('schedules and persists a reminder before the due time', () async {
    final task = makeTask(dueAt: DateTime.now().add(const Duration(hours: 3)));

    final scheduled = await useCase.schedule(
      task,
      title: 'Review brief',
      body: 'Design Systems',
    );

    expect(scheduled, isTrue);
    verify(() => reminders.upsert(any())).called(1);
    final captured = verify(
      () => scheduler.schedule(
        id: captureAny(named: 'id'),
        title: captureAny(named: 'title'),
        body: captureAny(named: 'body'),
        at: captureAny(named: 'at'),
      ),
    ).captured;
    expect(captured[1], 'Review brief');
    expect(captured[3], task.dueAt!.subtract(const Duration(minutes: 15)));
  });

  test('clears instead of scheduling when the instant has passed', () async {
    final task = makeTask(
      dueAt: DateTime.now().subtract(const Duration(hours: 2)),
    );

    final scheduled = await useCase.schedule(task, title: 'T', body: 'B');

    expect(scheduled, isFalse);
    verify(() => scheduler.cancel(any())).called(1);
    verifyNever(() => reminders.upsert(any()));
  });

  test('clears the reminder for a task', () async {
    await useCase.clear(makeTask());

    verify(() => scheduler.cancel(any())).called(1);
    verify(() => reminders.deleteForTask(any())).called(1);
  });

  test('uses the same notification id as the deletion paths', () {
    final task = makeTask(id: 'abc');
    expect(
      SetTaskReminder.notificationIdFor(task),
      IdGenerator.notificationIdFor(task.id),
    );
  });
}

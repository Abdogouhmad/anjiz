import 'package:anjiz/domain/repositories/task_repository.dart';
import 'package:anjiz/domain/usecases/watch_today_tasks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../support/fixtures.dart';

class _MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  final now = DateTime(2026, 10, 16, 15, 30);
  final useCase = WatchTodayTasks(_MockTaskRepository());

  group('WatchTodayTasks.group', () {
    test('separates overdue, timed, untimed and completed-today tasks', () {
      final agenda = useCase.group([
        // Overdue: due yesterday, still open.
        makeTask(id: 'overdue', dueAt: DateTime(2026, 10, 15, 9)),
        // Timed today.
        makeTask(
          id: 'timed',
          dueAt: DateTime(2026, 10, 16, 11, 30),
          hasTime: true,
        ),
        // Untimed today.
        makeTask(id: 'untimed', dueAt: DateTime(2026, 10, 16)),
        // Completed today.
        makeTask(
          id: 'done',
          isDone: true,
          dueAt: DateTime(2026, 10, 16, 7, 45),
          completedAt: DateTime(2026, 10, 16, 7, 45),
        ),
        // Completed yesterday: excluded.
        makeTask(
          id: 'done-old',
          isDone: true,
          completedAt: DateTime(2026, 10, 15, 18),
        ),
        // No due date: excluded.
        makeTask(id: 'someday'),
      ], now);

      expect(agenda.overdue.map((task) => task.id), ['overdue']);
      expect(agenda.scheduled.map((task) => task.id), ['timed']);
      expect(agenda.anytime.map((task) => task.id), ['untimed']);
      expect(agenda.completed.map((task) => task.id), ['done']);
      expect(agenda.remaining, 3);
      expect(agenda.isClear, isFalse);
    });

    test('reports a clear day when nothing is left', () {
      final agenda = useCase.group([
        makeTask(id: 'done', isDone: true, completedAt: now),
      ], now);

      expect(agenda.isClear, isTrue);
      expect(agenda.remaining, 0);
      expect(agenda.completed.length, 1);
    });
  });
}

import 'package:anjiz/domain/repositories/task_repository.dart';
import 'package:anjiz/domain/usecases/watch_upcoming_tasks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../support/fixtures.dart';

class _MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  final start = DateTime(2026, 10, 17);
  final end = DateTime(2026, 10, 24);
  final useCase = WatchUpcomingTasks(_MockTaskRepository());

  group('WatchUpcomingTasks.group', () {
    test('buckets open tasks into ordered empty-inclusive days', () {
      final agenda = useCase.group(
        [
          makeTask(id: 'a', dueAt: DateTime(2026, 10, 17, 9), hasTime: true),
          makeTask(id: 'b', dueAt: DateTime(2026, 10, 17, 12), hasTime: true),
          makeTask(id: 'c', dueAt: DateTime(2026, 10, 19, 16), hasTime: true),
          // Ignored: completed.
          makeTask(id: 'done', isDone: true, dueAt: DateTime(2026, 10, 17)),
          // Ignored: today, before the window.
          makeTask(id: 'today', dueAt: DateTime(2026, 10, 16, 10)),
          // Ignored: past the seven-day window.
          makeTask(id: 'later', dueAt: DateTime(2026, 10, 25)),
          // Ignored: no due date.
          makeTask(id: 'someday'),
        ],
        start: start,
        end: end,
        days: 7,
      );

      expect(agenda.days.length, 7);
      expect(agenda.days.first.date, DateTime(2026, 10, 17));
      expect(agenda.days.first.tasks.map((task) => task.id), ['a', 'b']);
      expect(agenda.days[1].tasks, isEmpty);
      expect(agenda.days[2].tasks.map((task) => task.id), ['c']);
      expect(agenda.total, 3);
      expect(agenda.momentum, closeTo(2 / 7, 0.0001));
    });

    test('returns zero momentum when nothing is scheduled', () {
      final agenda = useCase.group(const [], start: start, end: end, days: 7);

      expect(agenda.total, 0);
      expect(agenda.momentum, 0);
    });
  });
}

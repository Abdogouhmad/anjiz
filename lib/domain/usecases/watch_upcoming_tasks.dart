import '../entities/task.dart';
import '../entities/upcoming_agenda.dart';
import '../entities/upcoming_day.dart';
import '../repositories/task_repository.dart';

/// Groups the next [days] calendar days into an [UpcomingAgenda], including
/// days with no tasks so the momentum card reflects real emptiness.
class WatchUpcomingTasks {
  /// Creates the use case.
  const WatchUpcomingTasks(this._tasks);

  final TaskRepository _tasks;

  /// Streams the upcoming agenda as tasks change.
  Stream<UpcomingAgenda> call(DateTime now, {int days = 7}) {
    final start = DateTime(now.year, now.month, now.day + 1);
    final end = start.add(Duration(days: days));
    return _tasks
        .watchUpcoming(start)
        .map((tasks) => group(tasks, start: start, end: end, days: days));
  }

  /// Pure grouping logic, exposed for testing.
  UpcomingAgenda group(
    List<Task> tasks, {
    required DateTime start,
    required DateTime end,
    required int days,
  }) {
    final buckets = <DateTime, List<Task>>{};
    for (final task in tasks) {
      final due = task.dueAt;
      if (due == null || task.isDone) continue;
      if (due.isBefore(start) || !due.isBefore(end)) continue;
      final day = DateTime(due.year, due.month, due.day);
      buckets.putIfAbsent(day, () => <Task>[]).add(task);
    }

    final result = <UpcomingDay>[];
    var total = 0;
    for (var i = 0; i < days; i++) {
      final date = start.add(Duration(days: i));
      final dayTasks = buckets[date] ?? const <Task>[];
      total += dayTasks.length;
      result.add(UpcomingDay(date: date, tasks: dayTasks));
    }
    return UpcomingAgenda(days: result, total: total);
  }
}

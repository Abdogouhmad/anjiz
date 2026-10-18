import '../../core/extensions/datetime_extensions.dart';
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
  ///
  /// The window starts tomorrow; today's tasks live on the Today screen.
  Stream<UpcomingAgenda> call(DateTime now, {int days = 7}) {
    final start = now.startOfDay.startOfNextDay;
    final end = _dayAt(start, days);
    return _tasks
        .watchUpcoming(start)
        .map((tasks) => group(tasks, start: start, end: end, days: days));
  }

  /// Pure grouping logic, exposed for testing.
  ///
  /// Day buckets are built from calendar arithmetic (never `Duration` maths)
  /// so a daylight-saving shift can never orphan a whole day's tasks.
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
      buckets.putIfAbsent(due.startOfDay, () => <Task>[]).add(task);
    }

    final result = <UpcomingDay>[];
    var total = 0;
    for (var i = 0; i < days; i++) {
      final date = _dayAt(start, i);
      final dayTasks = List.of(buckets[date] ?? const <Task>[]);
      _sort(dayTasks);
      total += dayTasks.length;
      result.add(UpcomingDay(date: date, tasks: dayTasks));
    }
    return UpcomingAgenda(days: result, total: total);
  }

  /// Midnight of the day [offset] calendar days after [start].
  static DateTime _dayAt(DateTime start, int offset) =>
      DateTime(start.year, start.month, start.day + offset);

  /// Timed tasks first by time, then untimed by priority and manual order.
  void _sort(List<Task> tasks) {
    tasks.sort((a, b) {
      if (a.hasTime != b.hasTime) return a.hasTime ? -1 : 1;
      if (a.hasTime && b.hasTime) return a.dueAt!.compareTo(b.dueAt!);
      final byPriority = b.priority.value.compareTo(a.priority.value);
      return byPriority != 0 ? byPriority : a.sortOrder.compareTo(b.sortOrder);
    });
  }
}

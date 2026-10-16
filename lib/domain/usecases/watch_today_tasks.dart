import '../../core/extensions/datetime_extensions.dart';
import '../entities/task.dart';
import '../entities/today_agenda.dart';
import '../repositories/task_repository.dart';

/// Groups all tasks into the [TodayAgenda] (overdue, timed, untimed, done).
class WatchTodayTasks {
  /// Creates the use case.
  const WatchTodayTasks(this._tasks);

  final TaskRepository _tasks;

  /// Streams the agenda as tasks change.
  Stream<TodayAgenda> call(DateTime now) =>
      _tasks.watchAll().map((tasks) => group(tasks, now));

  /// Pure grouping logic, exposed for testing.
  TodayAgenda group(List<Task> tasks, DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    final overdue = <Task>[];
    final scheduled = <Task>[];
    final anytime = <Task>[];
    final completed = <Task>[];

    for (final task in tasks) {
      if (task.isDone) {
        final completedAt = task.completedAt;
        if (completedAt != null && completedAt.isSameDay(now)) {
          completed.add(task);
        }
        continue;
      }
      final due = task.dueAt;
      if (due == null) continue;
      if (due.isBefore(today)) {
        overdue.add(task);
      } else if (due.isSameDay(now)) {
        (task.hasTime ? scheduled : anytime).add(task);
      }
    }

    return TodayAgenda(
      overdue: overdue,
      scheduled: scheduled,
      anytime: anytime,
      completed: completed,
    );
  }
}

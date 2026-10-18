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
  ///
  /// Every open task lands somewhere: undated tasks belong to the day too
  /// (the "anytime" bucket), so nothing silently disappears from the home
  /// screen. Tasks due in the future belong to Upcoming.
  TodayAgenda group(List<Task> tasks, DateTime now) {
    final today = now.startOfDay;
    final overdue = <Task>[];
    final scheduled = <Task>[];
    final anytime = <Task>[];
    final completed = <Task>[];

    for (final task in tasks) {
      final due = task.dueAt;
      if (task.isDone) {
        if (_completedToday(task, today)) completed.add(task);
        continue;
      }
      if (due == null) {
        anytime.add(task);
      } else if (due.isBefore(today)) {
        overdue.add(task);
      } else if (due.isSameDay(now)) {
        (task.hasTime ? scheduled : anytime).add(task);
      }
    }

    overdue.sort((a, b) => a.dueAt!.compareTo(b.dueAt!));
    scheduled.sort((a, b) => a.dueAt!.compareTo(b.dueAt!));
    anytime.sort(_byUrgency);
    completed.sort((a, b) => _finishedAt(b).compareTo(_finishedAt(a)));

    return TodayAgenda(
      overdue: overdue,
      scheduled: scheduled,
      anytime: anytime,
      completed: completed,
    );
  }

  /// A task counts as completed today when it was finished today, or (for
  /// rows completed before `completedAt` existed) when it was due today or
  /// earlier and has no completion timestamp.
  bool _completedToday(Task task, DateTime today) {
    final completedAt = task.completedAt;
    if (completedAt != null) return completedAt.isSameDay(today);
    final due = task.dueAt;
    return due != null && !due.isAfter(today);
  }

  /// The best-known completion instant, falling back to the due date.
  DateTime _finishedAt(Task task) =>
      task.completedAt ?? task.dueAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  /// Highest priority first, then starred, then earlier due dates.
  int _byUrgency(Task a, Task b) {
    final byPriority = b.priority.value.compareTo(a.priority.value);
    if (byPriority != 0) return byPriority;
    if (a.isStarred != b.isStarred) return a.isStarred ? -1 : 1;
    return (a.dueAt ?? DateTime(2100)).compareTo(b.dueAt ?? DateTime(2100));
  }
}

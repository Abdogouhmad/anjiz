import 'task.dart';

/// The grouped view of a single day: overdue carry-over, timed and untimed
/// tasks due today, and what was completed today.
class TodayAgenda {
  /// Creates a today agenda.
  const TodayAgenda({
    required this.overdue,
    required this.scheduled,
    required this.anytime,
    required this.completed,
  });

  /// An empty agenda.
  static const TodayAgenda empty = TodayAgenda(
    overdue: <Task>[],
    scheduled: <Task>[],
    anytime: <Task>[],
    completed: <Task>[],
  );

  /// Tasks due before today and still open.
  final List<Task> overdue;

  /// Open tasks due today with a specific time.
  final List<Task> scheduled;

  /// Open tasks due today without a time.
  final List<Task> anytime;

  /// Tasks completed today.
  final List<Task> completed;

  /// The number of tasks still requiring attention today.
  int get remaining => overdue.length + scheduled.length + anytime.length;

  /// Whether there is nothing left to do today.
  bool get isClear => remaining == 0;
}

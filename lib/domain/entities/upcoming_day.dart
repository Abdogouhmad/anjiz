import 'task.dart';

/// Tasks grouped under a single calendar day in the upcoming agenda.
class UpcomingDay {
  /// Creates an upcoming day group.
  const UpcomingDay({required this.date, required this.tasks});

  /// The calendar day these tasks belong to.
  final DateTime date;

  /// Tasks due on [date].
  final List<Task> tasks;
}

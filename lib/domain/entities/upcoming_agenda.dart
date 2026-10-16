import 'upcoming_day.dart';

/// The upcoming agenda: future days, each with their due tasks, plus a summary
/// ratio used by the momentum card.
class UpcomingAgenda {
  /// Creates an upcoming agenda.
  const UpcomingAgenda({required this.days, required this.total});

  /// An empty agenda.
  static const UpcomingAgenda empty = UpcomingAgenda(
    days: <UpcomingDay>[],
    total: 0,
  );

  /// Days with at least one task, ordered chronologically.
  final List<UpcomingDay> days;

  /// Total number of tasks across every day.
  final int total;

  /// Momentum: the share of the next seven days that carry work (0.0–1.0).
  double get momentum {
    if (days.isEmpty) return 0;
    final scheduled = days.where((day) => day.tasks.isNotEmpty).length;
    return (scheduled / 7).clamp(0, 1);
  }
}

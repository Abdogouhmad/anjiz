import '../../../../domain/entities/task_list.dart';

/// A task list plus the aggregate counts shown on the Lists screen card.
class TaskListSummary {
  /// Creates a summary.
  const TaskListSummary({
    required this.list,
    required this.remaining,
    required this.completed,
  });

  /// The underlying list.
  final TaskList list;

  /// Number of open tasks.
  final int remaining;

  /// Number of completed tasks.
  final int completed;

  /// Total tasks in the list.
  int get total => remaining + completed;

  /// Completion ratio in the range 0.0–1.0.
  double get progress {
    if (total == 0) return 0;
    return completed / total;
  }
}

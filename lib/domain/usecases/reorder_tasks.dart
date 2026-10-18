import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../services/widget_syncer.dart';

/// Persists a new manual ordering for a list of tasks.
class ReorderTasks {
  /// Creates the use case.
  const ReorderTasks({
    required TaskRepository tasks,
    required WidgetSyncer widgetSync,
  }) : _tasks = tasks,
       _widgetSync = widgetSync;

  final TaskRepository _tasks;
  final WidgetSyncer _widgetSync;

  /// Stores the order of [ordered] (index becomes the new sort order).
  Future<void> call(List<Task> ordered) async {
    await _tasks.reorder(ordered);
    await _widgetSync.sync();
  }
}

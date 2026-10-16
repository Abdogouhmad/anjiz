import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../services/widget_syncer.dart';

/// Persists edits to an existing task and refreshes the widgets.
class UpdateTask {
  /// Creates the use case.
  const UpdateTask({
    required TaskRepository tasks,
    required WidgetSyncer widgetSync,
  }) : _tasks = tasks,
       _widgetSync = widgetSync;

  final TaskRepository _tasks;
  final WidgetSyncer _widgetSync;

  /// Stores [task] with a refreshed `updatedAt` timestamp.
  Future<Task> call(Task task) async {
    final updated = task.copyWith(updatedAt: DateTime.now());
    await _tasks.upsert(updated);
    await _widgetSync.sync();
    return updated;
  }
}

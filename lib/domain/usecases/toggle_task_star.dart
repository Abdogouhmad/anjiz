import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../services/widget_syncer.dart';

/// Toggles the starred flag of a task.
class ToggleTaskStar {
  /// Creates the use case.
  const ToggleTaskStar({
    required TaskRepository tasks,
    required WidgetSyncer widgetSync,
  }) : _tasks = tasks,
       _widgetSync = widgetSync;

  final TaskRepository _tasks;
  final WidgetSyncer _widgetSync;

  /// Applies [isStarred] to [task].
  Future<void> call(Task task, {required bool isStarred}) async {
    await _tasks.setStarred(task.id, isStarred: isStarred);
    await _widgetSync.sync();
  }
}

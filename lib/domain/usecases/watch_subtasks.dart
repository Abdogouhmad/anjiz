import '../entities/subtask.dart';
import '../repositories/subtask_repository.dart';

/// Streams the checklist items for a task, plus derived progress.
class WatchSubtasks {
  /// Creates the use case.
  const WatchSubtasks(this._subtasks);

  final SubtaskRepository _subtasks;

  /// Streams the subtasks belonging to [taskId].
  Stream<List<Subtask>> call(String taskId) => _subtasks.watchForTask(taskId);
}

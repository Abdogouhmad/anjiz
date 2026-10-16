import '../entities/subtask.dart';
import '../repositories/subtask_repository.dart';

/// Removes a checklist item from a task.
class DeleteSubtask {
  /// Creates the use case.
  const DeleteSubtask(this._subtasks);

  final SubtaskRepository _subtasks;

  /// Deletes [subtask].
  Future<void> call(Subtask subtask) => _subtasks.delete(subtask.id);
}

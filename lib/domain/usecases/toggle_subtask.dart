import '../entities/subtask.dart';
import '../repositories/subtask_repository.dart';

/// Toggles the completion state of a checklist item.
class ToggleSubtask {
  /// Creates the use case.
  const ToggleSubtask(this._subtasks);

  final SubtaskRepository _subtasks;

  /// Applies [isDone] to [subtask].
  Future<void> call(Subtask subtask, {required bool isDone}) =>
      _subtasks.setDone(subtask.id, isDone: isDone);
}

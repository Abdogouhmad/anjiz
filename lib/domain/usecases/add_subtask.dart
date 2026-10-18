import '../../core/utils/id_generator.dart';
import '../entities/subtask.dart';
import '../repositories/subtask_repository.dart';

/// Adds a checklist item to a task.
class AddSubtask {
  /// Creates the use case.
  const AddSubtask(this._subtasks);

  final SubtaskRepository _subtasks;

  /// Creates and stores a subtask under [taskId].
  Future<Subtask> call({
    required String taskId,
    required String title,
    int sortOrder = 0,
  }) async {
    final subtask = Subtask(
      id: IdGenerator.newId(),
      taskId: taskId,
      title: title.trim(),
      sortOrder: sortOrder,
    );
    await _subtasks.upsert(subtask);
    return subtask;
  }
}

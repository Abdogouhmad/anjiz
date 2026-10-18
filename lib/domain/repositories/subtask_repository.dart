import '../entities/subtask.dart';

/// Read/write access to checklist items nested in a task.
abstract interface class SubtaskRepository {
  /// Streams subtasks for [taskId] ordered by manual position.
  Stream<List<Subtask>> watchForTask(String taskId);

  /// Inserts or replaces [subtask].
  Future<void> upsert(Subtask subtask);

  /// Sets the completion state of a subtask.
  Future<void> setDone(String id, {required bool isDone});

  /// Deletes a subtask.
  Future<void> delete(String id);
}

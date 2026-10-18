import '../entities/task_list.dart';

/// Read/write access to task lists.
abstract interface class TaskListRepository {
  /// Streams every list ordered by manual sort order.
  Stream<List<TaskList>> watchAll();

  /// Loads a list by id.
  Future<TaskList?> findById(String id);

  /// Inserts or replaces [list].
  Future<void> upsert(TaskList list);

  /// Deletes a list and its tasks.
  Future<void> delete(String id);

  /// Returns the default list, creating it when missing.
  Future<TaskList> ensureDefault(String name);
}

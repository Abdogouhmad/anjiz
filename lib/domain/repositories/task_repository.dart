import '../entities/task.dart';

/// Read/write access to tasks. Implemented by the data layer.
abstract interface class TaskRepository {
  /// Streams every task, ordered by due date then manual order.
  Stream<List<Task>> watchAll();

  /// Streams all tasks belonging to [listId].
  Stream<List<Task>> watchForList(String listId);

  /// Streams tasks due on [day] (any time), including completed ones.
  Stream<List<Task>> watchForDay(DateTime day);

  /// Streams tasks due on or after [from] (start of today), grouped by day.
  Stream<List<Task>> watchUpcoming(DateTime from);

  /// Streams tasks completed on [day].
  Stream<List<Task>> watchCompletedOn(DateTime day);

  /// Streams tasks whose title or notes match [query].
  Stream<List<Task>> watchSearch(String query);

  /// Streams the count of tasks still open in [listId].
  Stream<int> watchRemainingCount(String listId);

  /// Loads a single task by id.
  Future<Task?> findById(String id);

  /// Inserts or replaces [task].
  Future<void> upsert(Task task);

  /// Sets the completion state of a task.
  Future<void> setDone(
    String id, {
    required bool isDone,
    required DateTime? completedAt,
  });

  /// Sets the starred state of a task.
  Future<void> setStarred(String id, {required bool isStarred});

  /// Persists a new manual ordering.
  Future<void> reorder(List<Task> ordered);

  /// Deletes a task and its dependents.
  Future<void> delete(String id);

  /// Deletes every completed task.
  Future<void> deleteCompleted();
}

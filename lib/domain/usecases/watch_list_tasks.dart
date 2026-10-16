import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Streams the tasks belonging to a single list.
class WatchListTasks {
  /// Creates the use case.
  const WatchListTasks(this._tasks);

  final TaskRepository _tasks;

  /// Streams open and completed tasks for [listId].
  Stream<List<Task>> call(String listId) => _tasks.watchForList(listId);
}

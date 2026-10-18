import '../entities/task_list.dart';
import '../repositories/task_list_repository.dart';
import '../repositories/task_repository.dart';

/// Streams every task list together with its remaining open-task count.
class WatchTaskLists {
  /// Creates the use case.
  const WatchTaskLists({
    required TaskListRepository lists,
    required TaskRepository tasks,
  }) : _lists = lists,
       _tasks = tasks;

  final TaskListRepository _lists;
  final TaskRepository _tasks;

  /// Streams the lists.
  Stream<List<TaskList>> call() => _lists.watchAll();

  /// Streams the remaining open-task count for [listId].
  Stream<int> remaining(String listId) => _tasks.watchRemainingCount(listId);
}

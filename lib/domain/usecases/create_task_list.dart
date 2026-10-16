import '../../core/utils/id_generator.dart';
import '../entities/task_list.dart';
import '../repositories/task_list_repository.dart';

/// Creates a new task list.
class CreateTaskList {
  /// Creates the use case.
  const CreateTaskList(this._lists);

  final TaskListRepository _lists;

  /// Stores a new list and returns it.
  Future<TaskList> call({
    required String name,
    int color = 0xFF1B7A66,
    String icon = 'inbox',
    int sortOrder = 0,
  }) async {
    final list = TaskList(
      id: IdGenerator.newId(),
      name: name.trim(),
      color: color,
      icon: icon,
      sortOrder: sortOrder,
      createdAt: DateTime.now(),
    );
    await _lists.upsert(list);
    return list;
  }
}

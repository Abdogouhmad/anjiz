import '../../core/errors/failure.dart';
import '../../core/utils/id_generator.dart';
import '../entities/priority.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../services/widget_syncer.dart';

/// Creates a task, persists it and refreshes the home-screen widgets.
class AddTask {
  /// Creates the use case.
  const AddTask({
    required TaskRepository tasks,
    required WidgetSyncer widgetSync,
  }) : _tasks = tasks,
       _widgetSync = widgetSync;

  final TaskRepository _tasks;
  final WidgetSyncer _widgetSync;

  /// Creates and stores a task, returning the stored entity.
  Future<Task> call({
    required String title,
    required String listId,
    String notes = '',
    DateTime? dueAt,
    bool hasTime = false,
    Priority priority = Priority.none,
    String? repeatRule,
  }) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw const Failure.validation('Task title must not be empty');
    }
    final now = DateTime.now();
    final task = Task(
      id: IdGenerator.newId(),
      listId: listId,
      title: trimmed,
      notes: notes,
      priority: priority,
      dueAt: dueAt,
      hasTime: hasTime,
      repeatRule: repeatRule,
      sortOrder: now.millisecondsSinceEpoch,
      createdAt: now,
      updatedAt: now,
    );
    await _tasks.upsert(task);
    await _widgetSync.sync();
    return task;
  }
}

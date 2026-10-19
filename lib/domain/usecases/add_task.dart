import '../../core/errors/failure.dart';
import '../../core/utils/id_generator.dart';
import '../entities/priority.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../services/widget_syncer.dart';
import 'set_task_reminder.dart';

/// Creates a task, persists it, schedules its reminder and refreshes the
/// home-screen widgets.
class AddTask {
  /// Creates the use case. [reminder] is optional so callers without a
  /// scheduler can still create tasks; when present, a task created with a
  /// due date gets its reminder scheduled immediately (previously reminders
  /// were only ever registered from the manual toggle in task detail, which
  /// is why scheduled notifications never fired for new tasks).
  const AddTask({
    required TaskRepository tasks,
    required WidgetSyncer widgetSync,
    SetTaskReminder? reminder,
  }) : _tasks = tasks,
       _widgetSync = widgetSync,
       _reminder = reminder;

  final TaskRepository _tasks;
  final WidgetSyncer _widgetSync;
  final SetTaskReminder? _reminder;

  /// Creates and stores a task, returning the stored entity.
  ///
  /// [scheduleReminder] gates the reminder scheduling so the UI can opt out
  /// when notification permission was denied.
  Future<Task> call({
    required String title,
    required String listId,
    String notes = '',
    DateTime? dueAt,
    bool hasTime = false,
    Priority priority = Priority.none,
    String? repeatRule,
    bool scheduleReminder = true,
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
    final reminder = _reminder;
    if (scheduleReminder && reminder != null && dueAt != null) {
      await reminder.schedule(
        task,
        title: task.title,
        body: task.notes.isEmpty ? task.title : task.notes,
      );
    }
    await _widgetSync.sync();
    return task;
  }
}

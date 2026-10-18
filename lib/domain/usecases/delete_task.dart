import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../services/reminder_scheduler.dart';
import '../services/widget_syncer.dart';

/// Deletes a task, cancels its reminder and refreshes the widgets.
class DeleteTask {
  /// Creates the use case.
  const DeleteTask({
    required TaskRepository tasks,
    required WidgetSyncer widgetSync,
    required ReminderScheduler reminders,
  }) : _tasks = tasks,
       _widgetSync = widgetSync,
       _reminders = reminders;

  final TaskRepository _tasks;
  final WidgetSyncer _widgetSync;
  final ReminderScheduler _reminders;

  /// Deletes the task identified by [task].
  Future<void> call(Task task) async {
    await _reminders.cancel(task.id.hashCode & 0x7fffffff);
    await _tasks.delete(task.id);
    await _widgetSync.sync();
  }
}

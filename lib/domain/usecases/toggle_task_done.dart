import '../entities/task.dart';
import '../repositories/task_repository.dart';
import '../services/reminder_scheduler.dart';
import '../services/widget_syncer.dart';

/// Toggles completion, cancelling any pending reminder on completion.
class ToggleTaskDone {
  /// Creates the use case.
  const ToggleTaskDone({
    required TaskRepository tasks,
    required WidgetSyncer widgetSync,
    required ReminderScheduler reminders,
  }) : _tasks = tasks,
       _widgetSync = widgetSync,
       _reminders = reminders;

  final TaskRepository _tasks;
  final WidgetSyncer _widgetSync;
  final ReminderScheduler _reminders;

  /// Applies [isDone] to [task].
  Future<void> call(Task task, {required bool isDone}) async {
    await _tasks.setDone(
      task.id,
      isDone: isDone,
      completedAt: isDone ? DateTime.now() : null,
    );
    if (isDone) {
      await _reminders.cancel(task.id.hashCode & 0x7fffffff);
    }
    await _widgetSync.sync();
  }
}

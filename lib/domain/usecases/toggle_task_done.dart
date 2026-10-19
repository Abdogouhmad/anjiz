import '../entities/task.dart';
import '../repositories/reminder_repository.dart';
import '../repositories/task_repository.dart';
import '../services/reminder_scheduler.dart';
import '../services/widget_syncer.dart';
import 'set_task_reminder.dart';

/// Toggles completion, cancelling any pending reminder on completion and
/// restoring it when the task is reopened.
class ToggleTaskDone {
  /// Creates the use case. [reminders] is optional so callers without a
  /// reminder store can still toggle completion.
  const ToggleTaskDone({
    required TaskRepository tasks,
    required WidgetSyncer widgetSync,
    required ReminderScheduler reminders,
    ReminderRepository? reminderRows,
  }) : _tasks = tasks,
       _widgetSync = widgetSync,
       _reminders = reminders,
       _reminderRows = reminderRows;

  final TaskRepository _tasks;
  final WidgetSyncer _widgetSync;
  final ReminderScheduler _reminders;
  final ReminderRepository? _reminderRows;

  /// Applies [isDone] to [task].
  Future<void> call(Task task, {required bool isDone}) async {
    await _tasks.setDone(
      task.id,
      isDone: isDone,
      completedAt: isDone ? DateTime.now() : null,
    );
    final id = SetTaskReminder.notificationIdFor(task);
    if (isDone) {
      await _reminders.cancel(id);
    } else {
      await _restoreReminder(task, id);
    }
    await _widgetSync.sync();
  }

  /// Re-schedules the stored reminder when a completed task is reopened.
  Future<void> _restoreReminder(Task task, int id) async {
    final rows = _reminderRows;
    final due = task.dueAt;
    if (rows == null || due == null) return;
    if (!due.isAfter(DateTime.now())) return;
    final existing = await rows.watchForTask(task.id).first;
    if (existing.isEmpty) return;
    await _reminders.schedule(
      id: id,
      title: task.title,
      body: task.notes.isEmpty ? task.title : task.notes,
      at: existing.first.remindAt,
    );
  }
}

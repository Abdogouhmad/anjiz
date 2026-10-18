import '../entities/task.dart';
import '../repositories/reminder_repository.dart';
import '../repositories/task_repository.dart';
import '../services/reminder_scheduler.dart';
import '../services/widget_syncer.dart';
import 'set_task_reminder.dart';

/// Persists edits to an existing task, keeps any bound reminder in step with
/// the new due time, and refreshes the widgets.
class UpdateTask {
  /// Creates the use case. Reminder wiring is optional so callers that never
  /// schedule reminders can skip it.
  const UpdateTask({
    required TaskRepository tasks,
    required WidgetSyncer widgetSync,
    ReminderScheduler? scheduler,
    ReminderRepository? reminders,
  }) : _tasks = tasks,
       _widgetSync = widgetSync,
       _scheduler = scheduler,
       _reminders = reminders;

  /// Lead time kept when a reminder follows its task's due time.
  static const int minutesBefore = 15;

  final TaskRepository _tasks;
  final WidgetSyncer _widgetSync;
  final ReminderScheduler? _scheduler;
  final ReminderRepository? _reminders;

  /// Stores [task] with a refreshed `updatedAt` timestamp.
  Future<Task> call(Task task) async {
    final updated = task.copyWith(updatedAt: DateTime.now());
    final previous = await _tasks.findById(updated.id);
    await _tasks.upsert(updated);
    if (previous != null) await _resyncReminder(previous, updated);
    await _widgetSync.sync();
    return updated;
  }

  /// Moves the bound reminder to the new due time, or drops it when the task
  /// is no longer remindable (undated, or the moment has already passed).
  Future<void> _resyncReminder(Task previous, Task updated) async {
    final reminders = _reminders;
    final scheduler = _scheduler;
    if (reminders == null || scheduler == null) return;
    if (previous.dueAt == updated.dueAt) return;
    final existing = await reminders.watchForTask(updated.id).first;
    if (existing.isEmpty) return;
    final at = updated.dueAt?.subtract(const Duration(minutes: minutesBefore));
    final notificationId = SetTaskReminder.notificationIdFor(updated);
    if (at == null || !at.isAfter(DateTime.now())) {
      await scheduler.cancel(notificationId);
      await reminders.deleteForTask(updated.id);
      return;
    }
    await scheduler.schedule(
      id: notificationId,
      title: updated.title,
      body: updated.notes.isEmpty ? updated.title : updated.notes,
      at: at,
    );
    await reminders.upsert(existing.first.copyWith(remindAt: at));
  }
}

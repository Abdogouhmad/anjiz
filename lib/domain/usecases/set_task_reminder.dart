import '../../core/utils/id_generator.dart';
import '../entities/reminder.dart';
import '../entities/task.dart';
import '../repositories/reminder_repository.dart';
import '../services/reminder_scheduler.dart';

/// Schedules or clears the notification reminder bound to a task.
///
/// The notification copy is supplied by the presentation layer so the domain
/// layer stays free of localisation concerns.
class SetTaskReminder {
  /// Creates the use case.
  const SetTaskReminder({
    required ReminderRepository reminders,
    required ReminderScheduler scheduler,
  }) : _reminders = reminders,
       _scheduler = scheduler;

  final ReminderRepository _reminders;
  final ReminderScheduler _scheduler;

  /// Schedules a reminder [minutesBefore] the task's due time.
  ///
  /// Returns `false` when the task has no due date or the reminder instant has
  /// already passed.
  Future<bool> schedule(
    Task task, {
    required String title,
    required String body,
    int minutesBefore = 15,
  }) async {
    final due = task.dueAt;
    if (due == null) return false;
    final at = due.subtract(Duration(minutes: minutesBefore));
    final id = notificationIdFor(task);
    if (!at.isAfter(DateTime.now())) {
      await clear(task);
      return false;
    }
    await _reminders.deleteForTask(task.id);
    await _scheduler.schedule(id: id, title: title, body: body, at: at);
    await _reminders.upsert(
      Reminder(
        id: IdGenerator.newId(),
        taskId: task.id,
        remindAt: at,
        notificationId: id,
      ),
    );
    return true;
  }

  /// Cancels and forgets any reminder bound to [task].
  Future<void> clear(Task task) async {
    await _scheduler.cancel(notificationIdFor(task));
    await _reminders.deleteForTask(task.id);
  }

  /// The stable notification id used for [task] (shared with deletion paths).
  static int notificationIdFor(Task task) => task.id.hashCode & 0x7fffffff;
}

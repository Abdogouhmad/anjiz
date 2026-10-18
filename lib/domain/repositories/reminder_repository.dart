import '../entities/reminder.dart';

/// Read/write access to scheduled reminders.
abstract interface class ReminderRepository {
  /// Streams every reminder bound to [taskId].
  Stream<List<Reminder>> watchForTask(String taskId);

  /// Inserts or replaces [reminder].
  Future<void> upsert(Reminder reminder);

  /// Deletes every reminder bound to [taskId].
  Future<void> deleteForTask(String taskId);

  /// Returns all reminders (used when rescheduling after boot).
  Future<List<Reminder>> findAll();
}

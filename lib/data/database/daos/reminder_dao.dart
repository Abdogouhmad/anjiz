import 'package:drift/drift.dart';

import '../anjiz_database.dart';
import '../reminders_table.dart';

part 'reminder_dao.g.dart';

/// Database access for scheduled reminders.
@DriftAccessor(tables: [Reminders])
class ReminderDao extends DatabaseAccessor<AnjizDatabase>
    with _$ReminderDaoMixin {
  /// Creates a reminder DAO bound to [db].
  ReminderDao(super.db);

  /// Watches reminders bound to [taskId].
  Stream<List<ReminderRow>> watchForTask(String taskId) =>
      (select(reminders)..where((t) => t.taskId.equals(taskId))).watch();

  /// Returns every reminder (used when rescheduling after reboot).
  Future<List<ReminderRow>> findAll() => select(reminders).get();

  /// Inserts or replaces a reminder row.
  Future<void> upsertRow(RemindersCompanion companion) =>
      into(reminders).insertOnConflictUpdate(companion);

  /// Deletes every reminder bound to [taskId].
  Future<void> deleteForTask(String taskId) =>
      (delete(reminders)..where((t) => t.taskId.equals(taskId))).go();
}

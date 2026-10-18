import 'package:drift/drift.dart';

import 'tasks_table.dart';

/// Drift table for scheduled reminders bound to a task.
@DataClassName('ReminderRow')
class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get taskId =>
      text().references(Tasks, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get remindAt => dateTime()();
  IntColumn get notificationId => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

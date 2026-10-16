import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/reminder_dao.dart';
import 'daos/subtask_dao.dart';
import 'daos/task_dao.dart';
import 'daos/task_list_dao.dart';
import 'reminders_table.dart';
import 'subtasks_table.dart';
import 'task_lists_table.dart';
import 'tasks_table.dart';

part 'anjiz_database.g.dart';

/// Single source of truth for all persisted Anjiz data.
@DriftDatabase(
  tables: [TaskLists, Tasks, Subtasks, Reminders],
  daos: [TaskListDao, TaskDao, SubtaskDao, ReminderDao],
)
class AnjizDatabase extends _$AnjizDatabase {
  /// Opens the on-device database file.
  AnjizDatabase() : super(_openConnection());

  /// Opens the database with a caller-supplied executor (used by tests).
  AnjizDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'anjiz.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

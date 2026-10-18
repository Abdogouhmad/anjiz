import 'package:drift/drift.dart';

import 'task_lists_table.dart';

/// Drift table for tasks. `priority` is persisted as an integer index.
@DataClassName('TaskRow')
class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get listId =>
      text().references(TaskLists, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  BoolColumn get isStarred => boolean().withDefault(const Constant(false))();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  DateTimeColumn get dueAt => dateTime().nullable()();
  BoolColumn get hasTime => boolean().withDefault(const Constant(false))();
  TextColumn get repeatRule => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

import 'package:drift/drift.dart';

import '../anjiz_database.dart';
import '../task_lists_table.dart';

part 'task_list_dao.g.dart';

/// Database access for task lists.
@DriftAccessor(tables: [TaskLists])
class TaskListDao extends DatabaseAccessor<AnjizDatabase>
    with _$TaskListDaoMixin {
  /// Creates a task-list DAO bound to [db].
  TaskListDao(super.db);

  /// Watches every list ordered by manual sort order.
  Stream<List<TaskListRow>> watchAll() => (select(
    taskLists,
  )..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).watch();

  /// Loads a list by id.
  Future<TaskListRow?> findById(String id) =>
      (select(taskLists)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Counts stored lists (used to decide whether to seed the default list).
  Future<int> count() async {
    final query = selectOnly(taskLists)..addColumns([taskLists.id.count()]);
    final row = await query.getSingle();
    return row.read(taskLists.id.count()) ?? 0;
  }

  /// Inserts or replaces a list row.
  Future<void> upsertRow(TaskListsCompanion companion) =>
      into(taskLists).insertOnConflictUpdate(companion);

  /// Deletes a list by id.
  Future<void> deleteById(String id) =>
      (delete(taskLists)..where((t) => t.id.equals(id))).go();
}

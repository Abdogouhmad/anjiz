import 'package:drift/drift.dart';

import '../anjiz_database.dart';
import '../tasks_table.dart';

part 'task_dao.g.dart';

/// Database access for tasks: scoped streams plus mutation helpers.
@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AnjizDatabase> with _$TaskDaoMixin {
  /// Creates a task DAO bound to [db].
  TaskDao(super.db);

  /// Watches every task, open tasks first, then by due date, then manual order.
  Stream<List<TaskRow>> watchAll() => _watch(select(tasks));

  /// Watches tasks belonging to [listId].
  Stream<List<TaskRow>> watchForList(String listId) =>
      _watch(select(tasks)..where((t) => t.listId.equals(listId)));

  /// Watches tasks due on [day].
  Stream<List<TaskRow>> watchForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return _watch(
      select(tasks)..where(
        (t) =>
            t.dueAt.isBiggerOrEqualValue(start) &
            t.dueAt.isSmallerThanValue(end),
      ),
    );
  }

  /// Watches tasks due on or after [from].
  Stream<List<TaskRow>> watchUpcoming(DateTime from) =>
      _watch(select(tasks)..where((t) => t.dueAt.isBiggerOrEqualValue(from)));

  /// Watches tasks completed on [day].
  Stream<List<TaskRow>> watchCompletedOn(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return _watch(
      select(tasks)..where(
        (t) =>
            t.isDone.equals(true) &
            t.completedAt.isBiggerOrEqualValue(start) &
            t.completedAt.isSmallerThanValue(end),
      ),
    );
  }

  /// Watches tasks whose title or notes contain [query].
  Stream<List<TaskRow>> watchSearch(String query) {
    final pattern = '%$query%';
    return _watch(
      select(tasks)
        ..where((t) => t.title.like(pattern) | t.notes.like(pattern)),
    );
  }

  /// Watches the number of open tasks in [listId].
  Stream<int> watchRemainingCount(String listId) {
    final count = tasks.id.count();
    final query = selectOnly(tasks)
      ..addColumns([count])
      ..where(tasks.listId.equals(listId) & tasks.isDone.equals(false));
    return query.map((row) => row.read(count) ?? 0).watchSingle();
  }

  /// Loads a task by id.
  Future<TaskRow?> findById(String id) =>
      (select(tasks)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Inserts or replaces a task row.
  Future<void> upsertRow(TasksCompanion companion) =>
      into(tasks).insertOnConflictUpdate(companion);

  /// Sets the completion state for a task.
  Future<void> setDone(
    String id, {
    required bool isDone,
    DateTime? completedAt,
  }) {
    return (update(tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        isDone: Value(isDone),
        completedAt: Value(completedAt),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Sets the starred state for a task.
  Future<void> setStarred(String id, {required bool isStarred}) {
    return (update(tasks)..where((t) => t.id.equals(id))).write(
      TasksCompanion(
        isStarred: Value(isStarred),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Applies a manual order to [idsInOrder].
  Future<void> reorder(List<String> idsInOrder) {
    return batch((batch) {
      for (var i = 0; i < idsInOrder.length; i++) {
        batch.update(
          tasks,
          TasksCompanion(sortOrder: Value(i)),
          where: (t) => t.id.equals(idsInOrder[i]),
        );
      }
    });
  }

  /// Deletes a task by id.
  Future<void> deleteById(String id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();

  /// Deletes all completed tasks.
  Future<void> deleteCompleted() =>
      (delete(tasks)..where((t) => t.isDone.equals(true))).go();

  Stream<List<TaskRow>> _watch(
    SimpleSelectStatement<$TasksTable, TaskRow> query,
  ) {
    query.orderBy([
      (t) => OrderingTerm(expression: t.isDone),
      (t) => OrderingTerm(expression: t.dueAt.isNull()),
      (t) => OrderingTerm(expression: t.dueAt),
      (t) => OrderingTerm(expression: t.sortOrder),
    ]);
    return query.watch();
  }
}

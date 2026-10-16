import 'package:drift/drift.dart';

import '../anjiz_database.dart';
import '../subtasks_table.dart';

part 'subtask_dao.g.dart';

/// Database access for nested checklist items.
@DriftAccessor(tables: [Subtasks])
class SubtaskDao extends DatabaseAccessor<AnjizDatabase>
    with _$SubtaskDaoMixin {
  /// Creates a subtask DAO bound to [db].
  SubtaskDao(super.db);

  /// Watches subtasks for [taskId] ordered by position.
  Stream<List<SubtaskRow>> watchForTask(String taskId) {
    return (select(subtasks)
          ..where((t) => t.taskId.equals(taskId))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .watch();
  }

  /// Inserts or replaces a subtask row.
  Future<void> upsertRow(SubtasksCompanion companion) =>
      into(subtasks).insertOnConflictUpdate(companion);

  /// Sets the completion state of a subtask.
  Future<void> setDone(String id, {required bool isDone}) {
    return (update(subtasks)..where((t) => t.id.equals(id))).write(
      SubtasksCompanion(isDone: Value(isDone)),
    );
  }

  /// Deletes a subtask by id.
  Future<void> deleteById(String id) =>
      (delete(subtasks)..where((t) => t.id.equals(id))).go();
}

import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../database/anjiz_database.dart';
import '../database/daos/task_dao.dart';
import '../mappers/task_mapper.dart';

/// Drift-backed implementation of [TaskRepository].
class TaskRepositoryImpl implements TaskRepository {
  /// Creates a repository over [dao].
  TaskRepositoryImpl(this._dao);

  final TaskDao _dao;

  Stream<List<Task>> _map(Stream<List<TaskRow>> source) =>
      source.map((rows) => rows.map((row) => row.toEntity()).toList());

  @override
  Stream<List<Task>> watchAll() => _map(_dao.watchAll());

  @override
  Stream<List<Task>> watchForList(String listId) =>
      _map(_dao.watchForList(listId));

  @override
  Stream<List<Task>> watchForDay(DateTime day) => _map(_dao.watchForDay(day));

  @override
  Stream<List<Task>> watchUpcoming(DateTime from) =>
      _map(_dao.watchUpcoming(from));

  @override
  Stream<List<Task>> watchCompletedOn(DateTime day) =>
      _map(_dao.watchCompletedOn(day));

  @override
  Stream<List<Task>> watchSearch(String query) => _map(_dao.watchSearch(query));

  @override
  Stream<int> watchRemainingCount(String listId) =>
      _dao.watchRemainingCount(listId);

  @override
  Future<Task?> findById(String id) async {
    final row = await _dao.findById(id);
    return row?.toEntity();
  }

  @override
  Future<void> upsert(Task task) => _dao.upsertRow(task.toCompanion());

  @override
  Future<void> setDone(
    String id, {
    required bool isDone,
    required DateTime? completedAt,
  }) => _dao.setDone(id, isDone: isDone, completedAt: completedAt);

  @override
  Future<void> setStarred(String id, {required bool isStarred}) =>
      _dao.setStarred(id, isStarred: isStarred);

  @override
  Future<void> reorder(List<Task> ordered) =>
      _dao.reorder(ordered.map((task) => task.id).toList());

  @override
  Future<void> delete(String id) => _dao.deleteById(id);

  @override
  Future<void> deleteCompleted() => _dao.deleteCompleted();
}

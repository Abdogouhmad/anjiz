import '../../domain/entities/subtask.dart';
import '../../domain/repositories/subtask_repository.dart';
import '../database/daos/subtask_dao.dart';
import '../mappers/subtask_mapper.dart';

/// Drift-backed implementation of [SubtaskRepository].
class SubtaskRepositoryImpl implements SubtaskRepository {
  /// Creates a repository over [dao].
  SubtaskRepositoryImpl(this._dao);

  final SubtaskDao _dao;

  @override
  Stream<List<Subtask>> watchForTask(String taskId) => _dao
      .watchForTask(taskId)
      .map((rows) => rows.map((row) => row.toEntity()).toList());

  @override
  Future<void> upsert(Subtask subtask) => _dao.upsertRow(subtask.toCompanion());

  @override
  Future<void> setDone(String id, {required bool isDone}) =>
      _dao.setDone(id, isDone: isDone);

  @override
  Future<void> delete(String id) => _dao.deleteById(id);
}

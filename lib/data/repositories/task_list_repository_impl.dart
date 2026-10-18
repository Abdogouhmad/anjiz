import '../../core/constants/app_constants.dart';
import '../../domain/entities/task_list.dart';
import '../../domain/repositories/task_list_repository.dart';
import '../database/daos/task_list_dao.dart';
import '../mappers/task_list_mapper.dart';

/// Drift-backed implementation of [TaskListRepository].
class TaskListRepositoryImpl implements TaskListRepository {
  /// Creates a repository over [dao].
  TaskListRepositoryImpl(this._dao);

  final TaskListDao _dao;

  @override
  Stream<List<TaskList>> watchAll() =>
      _dao.watchAll().map((rows) => rows.map((row) => row.toEntity()).toList());

  @override
  Future<TaskList?> findById(String id) async {
    final row = await _dao.findById(id);
    return row?.toEntity();
  }

  @override
  Future<void> upsert(TaskList list) => _dao.upsertRow(list.toCompanion());

  @override
  Future<void> delete(String id) => _dao.deleteById(id);

  @override
  Future<TaskList> ensureDefault(String name) async {
    final existing = await _dao.findById(AppConstants.defaultListId);
    if (existing != null) return existing.toEntity();
    final now = DateTime.now();
    final list = TaskList(
      id: AppConstants.defaultListId,
      name: name,
      color: 0xFF1B7A66,
      icon: 'inbox',
      sortOrder: 0,
      createdAt: now,
    );
    await _dao.upsertRow(list.toCompanion());
    return list;
  }
}

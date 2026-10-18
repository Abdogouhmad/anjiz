import '../../domain/entities/reminder.dart';
import '../../domain/repositories/reminder_repository.dart';
import '../database/daos/reminder_dao.dart';
import '../mappers/reminder_mapper.dart';

/// Drift-backed implementation of [ReminderRepository].
class ReminderRepositoryImpl implements ReminderRepository {
  /// Creates a repository over [dao].
  ReminderRepositoryImpl(this._dao);

  final ReminderDao _dao;

  @override
  Stream<List<Reminder>> watchForTask(String taskId) => _dao
      .watchForTask(taskId)
      .map((rows) => rows.map((row) => row.toEntity()).toList());

  @override
  Future<void> upsert(Reminder reminder) =>
      _dao.upsertRow(reminder.toCompanion());

  @override
  Future<void> deleteForTask(String taskId) => _dao.deleteForTask(taskId);

  @override
  Future<List<Reminder>> findAll() async {
    final rows = await _dao.findAll();
    return rows.map((row) => row.toEntity()).toList();
  }
}

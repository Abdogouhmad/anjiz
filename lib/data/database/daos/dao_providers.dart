import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database_provider.dart';
import 'reminder_dao.dart';
import 'subtask_dao.dart';
import 'task_dao.dart';
import 'task_list_dao.dart';

part 'dao_providers.g.dart';

/// Provides the task DAO.
@Riverpod(keepAlive: true)
TaskDao taskDao(Ref ref) => ref.watch(databaseProvider).taskDao;

/// Provides the task-list DAO.
@Riverpod(keepAlive: true)
TaskListDao taskListDao(Ref ref) => ref.watch(databaseProvider).taskListDao;

/// Provides the subtask DAO.
@Riverpod(keepAlive: true)
SubtaskDao subtaskDao(Ref ref) => ref.watch(databaseProvider).subtaskDao;

/// Provides the reminder DAO.
@Riverpod(keepAlive: true)
ReminderDao reminderDao(Ref ref) => ref.watch(databaseProvider).reminderDao;

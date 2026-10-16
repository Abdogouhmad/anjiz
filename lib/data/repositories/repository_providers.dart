import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/reminder_repository.dart';
import '../../domain/repositories/subtask_repository.dart';
import '../../domain/repositories/task_list_repository.dart';
import '../../domain/repositories/task_repository.dart';
import '../database/daos/dao_providers.dart';
import 'reminder_repository_impl.dart';
import 'subtask_repository_impl.dart';
import 'task_list_repository_impl.dart';
import 'task_repository_impl.dart';

part 'repository_providers.g.dart';

/// Provides the task repository implementation.
@Riverpod(keepAlive: true)
TaskRepository taskRepository(Ref ref) =>
    TaskRepositoryImpl(ref.watch(taskDaoProvider));

/// Provides the task-list repository implementation.
@Riverpod(keepAlive: true)
TaskListRepository taskListRepository(Ref ref) =>
    TaskListRepositoryImpl(ref.watch(taskListDaoProvider));

/// Provides the subtask repository implementation.
@Riverpod(keepAlive: true)
SubtaskRepository subtaskRepository(Ref ref) =>
    SubtaskRepositoryImpl(ref.watch(subtaskDaoProvider));

/// Provides the reminder repository implementation.
@Riverpod(keepAlive: true)
ReminderRepository reminderRepository(Ref ref) =>
    ReminderRepositoryImpl(ref.watch(reminderDaoProvider));

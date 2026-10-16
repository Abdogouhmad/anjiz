import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/repository_providers.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_list.dart';
import 'use_case_providers.dart';

part 'task_queries.g.dart';

/// Streams every task list ordered by manual sort position.
@riverpod
Stream<List<TaskList>> taskLists(Ref ref) =>
    ref.watch(watchTaskListsProvider).call();

/// Streams every task (used for cross-list summaries and search).
@riverpod
Stream<List<Task>> allTasks(Ref ref) =>
    ref.watch(taskRepositoryProvider).watchAll();

/// Streams the tasks belonging to [listId].
@riverpod
Stream<List<Task>> listTasks(Ref ref, String listId) =>
    ref.watch(watchListTasksProvider).call(listId);

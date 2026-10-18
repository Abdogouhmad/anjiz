import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/providers/task_queries.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/task_list.dart';
import 'task_list_summary.dart';

part 'task_list_summaries_provider.g.dart';

/// Derives each list together with its remaining/completed counts from the
/// live task queries.
@riverpod
List<TaskListSummary> taskListSummaries(Ref ref) {
  final lists = ref.watch(taskListsProvider).value ?? const <TaskList>[];
  final tasks = ref.watch(allTasksProvider).value ?? const <Task>[];
  return [
    for (final list in lists)
      TaskListSummary(
        list: list,
        remaining: tasks
            .where((task) => task.listId == list.id && !task.isDone)
            .length,
        completed: tasks
            .where((task) => task.listId == list.id && task.isDone)
            .length,
      ),
  ];
}

/// The total number of open tasks across every list.
@riverpod
int activeTaskCount(Ref ref) {
  final tasks = ref.watch(allTasksProvider).value ?? const <Task>[];
  return tasks.where((task) => !task.isDone).length;
}

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/services/service_providers.dart';
import '../../data/repositories/repository_providers.dart';
import '../../domain/usecases/add_subtask.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/create_task_list.dart';
import '../../domain/usecases/delete_subtask.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/reorder_tasks.dart';
import '../../domain/usecases/set_task_reminder.dart';
import '../../domain/usecases/toggle_subtask.dart';
import '../../domain/usecases/toggle_task_done.dart';
import '../../domain/usecases/toggle_task_star.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/watch_list_tasks.dart';
import '../../domain/usecases/watch_subtasks.dart';
import '../../domain/usecases/watch_task_lists.dart';
import '../../domain/usecases/watch_today_tasks.dart';
import '../../domain/usecases/watch_upcoming_tasks.dart';

part 'use_case_providers.g.dart';

/// Provides the [AddTask] use case.
@riverpod
AddTask addTask(Ref ref) => AddTask(
  tasks: ref.watch(taskRepositoryProvider),
  widgetSync: ref.watch(widgetSyncServiceProvider),
  reminder: ref.watch(setTaskReminderProvider),
);

/// Provides the [UpdateTask] use case.
@riverpod
UpdateTask updateTask(Ref ref) => UpdateTask(
  tasks: ref.watch(taskRepositoryProvider),
  widgetSync: ref.watch(widgetSyncServiceProvider),
  scheduler: ref.watch(notificationServiceProvider),
  reminders: ref.watch(reminderRepositoryProvider),
);

/// Provides the [DeleteTask] use case.
@riverpod
DeleteTask deleteTask(Ref ref) => DeleteTask(
  tasks: ref.watch(taskRepositoryProvider),
  widgetSync: ref.watch(widgetSyncServiceProvider),
  reminders: ref.watch(notificationServiceProvider),
);

/// Provides the [ToggleTaskDone] use case.
@riverpod
ToggleTaskDone toggleTaskDone(Ref ref) => ToggleTaskDone(
  tasks: ref.watch(taskRepositoryProvider),
  widgetSync: ref.watch(widgetSyncServiceProvider),
  reminders: ref.watch(notificationServiceProvider),
  reminderRows: ref.watch(reminderRepositoryProvider),
);

/// Provides the [ToggleTaskStar] use case.
@riverpod
ToggleTaskStar toggleTaskStar(Ref ref) => ToggleTaskStar(
  tasks: ref.watch(taskRepositoryProvider),
  widgetSync: ref.watch(widgetSyncServiceProvider),
);

/// Provides the [ReorderTasks] use case.
@riverpod
ReorderTasks reorderTasks(Ref ref) => ReorderTasks(
  tasks: ref.watch(taskRepositoryProvider),
  widgetSync: ref.watch(widgetSyncServiceProvider),
);

/// Provides the [WatchTodayTasks] use case.
@riverpod
WatchTodayTasks watchTodayTasks(Ref ref) =>
    WatchTodayTasks(ref.watch(taskRepositoryProvider));

/// Provides the [WatchUpcomingTasks] use case.
@riverpod
WatchUpcomingTasks watchUpcomingTasks(Ref ref) =>
    WatchUpcomingTasks(ref.watch(taskRepositoryProvider));

/// Provides the [WatchListTasks] use case.
@riverpod
WatchListTasks watchListTasks(Ref ref) =>
    WatchListTasks(ref.watch(taskRepositoryProvider));

/// Provides the [WatchSubtasks] use case.
@riverpod
WatchSubtasks watchSubtasks(Ref ref) =>
    WatchSubtasks(ref.watch(subtaskRepositoryProvider));

/// Provides the [AddSubtask] use case.
@riverpod
AddSubtask addSubtask(Ref ref) =>
    AddSubtask(ref.watch(subtaskRepositoryProvider));

/// Provides the [ToggleSubtask] use case.
@riverpod
ToggleSubtask toggleSubtask(Ref ref) =>
    ToggleSubtask(ref.watch(subtaskRepositoryProvider));

/// Provides the [DeleteSubtask] use case.
@riverpod
DeleteSubtask deleteSubtask(Ref ref) =>
    DeleteSubtask(ref.watch(subtaskRepositoryProvider));

/// Provides the [WatchTaskLists] use case.
@riverpod
WatchTaskLists watchTaskLists(Ref ref) => WatchTaskLists(
  lists: ref.watch(taskListRepositoryProvider),
  tasks: ref.watch(taskRepositoryProvider),
);

/// Provides the [CreateTaskList] use case.
@riverpod
CreateTaskList createTaskList(Ref ref) =>
    CreateTaskList(ref.watch(taskListRepositoryProvider));

/// Provides the [SetTaskReminder] use case.
@riverpod
SetTaskReminder setTaskReminder(Ref ref) => SetTaskReminder(
  reminders: ref.watch(reminderRepositoryProvider),
  scheduler: ref.watch(notificationServiceProvider),
);

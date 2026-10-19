// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'use_case_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the [AddTask] use case.

@ProviderFor(addTask)
final addTaskProvider = AddTaskProvider._();

/// Provides the [AddTask] use case.

final class AddTaskProvider
    extends $FunctionalProvider<AddTask, AddTask, AddTask>
    with $Provider<AddTask> {
  /// Provides the [AddTask] use case.
  AddTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addTaskHash();

  @$internal
  @override
  $ProviderElement<AddTask> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddTask create(Ref ref) {
    return addTask(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddTask value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddTask>(value),
    );
  }
}

String _$addTaskHash() => r'bc2c85d3842f4993daf13fe18c13b80e7475bb4c';

/// Provides the [UpdateTask] use case.

@ProviderFor(updateTask)
final updateTaskProvider = UpdateTaskProvider._();

/// Provides the [UpdateTask] use case.

final class UpdateTaskProvider
    extends $FunctionalProvider<UpdateTask, UpdateTask, UpdateTask>
    with $Provider<UpdateTask> {
  /// Provides the [UpdateTask] use case.
  UpdateTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateTaskHash();

  @$internal
  @override
  $ProviderElement<UpdateTask> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateTask create(Ref ref) {
    return updateTask(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateTask value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateTask>(value),
    );
  }
}

String _$updateTaskHash() => r'126bcf3926e46f4b12a4b53188572ea0256a5ccd';

/// Provides the [DeleteTask] use case.

@ProviderFor(deleteTask)
final deleteTaskProvider = DeleteTaskProvider._();

/// Provides the [DeleteTask] use case.

final class DeleteTaskProvider
    extends $FunctionalProvider<DeleteTask, DeleteTask, DeleteTask>
    with $Provider<DeleteTask> {
  /// Provides the [DeleteTask] use case.
  DeleteTaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTaskHash();

  @$internal
  @override
  $ProviderElement<DeleteTask> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteTask create(Ref ref) {
    return deleteTask(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteTask value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteTask>(value),
    );
  }
}

String _$deleteTaskHash() => r'51232ac60b5f12262b19457cbede4a893df91450';

/// Provides the [ToggleTaskDone] use case.

@ProviderFor(toggleTaskDone)
final toggleTaskDoneProvider = ToggleTaskDoneProvider._();

/// Provides the [ToggleTaskDone] use case.

final class ToggleTaskDoneProvider
    extends $FunctionalProvider<ToggleTaskDone, ToggleTaskDone, ToggleTaskDone>
    with $Provider<ToggleTaskDone> {
  /// Provides the [ToggleTaskDone] use case.
  ToggleTaskDoneProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toggleTaskDoneProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toggleTaskDoneHash();

  @$internal
  @override
  $ProviderElement<ToggleTaskDone> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ToggleTaskDone create(Ref ref) {
    return toggleTaskDone(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ToggleTaskDone value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ToggleTaskDone>(value),
    );
  }
}

String _$toggleTaskDoneHash() => r'c786592c689e8aa1f1b4344fd75de20bdd786985';

/// Provides the [ToggleTaskStar] use case.

@ProviderFor(toggleTaskStar)
final toggleTaskStarProvider = ToggleTaskStarProvider._();

/// Provides the [ToggleTaskStar] use case.

final class ToggleTaskStarProvider
    extends $FunctionalProvider<ToggleTaskStar, ToggleTaskStar, ToggleTaskStar>
    with $Provider<ToggleTaskStar> {
  /// Provides the [ToggleTaskStar] use case.
  ToggleTaskStarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toggleTaskStarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toggleTaskStarHash();

  @$internal
  @override
  $ProviderElement<ToggleTaskStar> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ToggleTaskStar create(Ref ref) {
    return toggleTaskStar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ToggleTaskStar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ToggleTaskStar>(value),
    );
  }
}

String _$toggleTaskStarHash() => r'73436b19d67ca34971cec749803c045c1a3725b8';

/// Provides the [ReorderTasks] use case.

@ProviderFor(reorderTasks)
final reorderTasksProvider = ReorderTasksProvider._();

/// Provides the [ReorderTasks] use case.

final class ReorderTasksProvider
    extends $FunctionalProvider<ReorderTasks, ReorderTasks, ReorderTasks>
    with $Provider<ReorderTasks> {
  /// Provides the [ReorderTasks] use case.
  ReorderTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reorderTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reorderTasksHash();

  @$internal
  @override
  $ProviderElement<ReorderTasks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReorderTasks create(Ref ref) {
    return reorderTasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReorderTasks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReorderTasks>(value),
    );
  }
}

String _$reorderTasksHash() => r'dec11a2e67385aadbbf9461db857a9e8061b10f4';

/// Provides the [WatchTodayTasks] use case.

@ProviderFor(watchTodayTasks)
final watchTodayTasksProvider = WatchTodayTasksProvider._();

/// Provides the [WatchTodayTasks] use case.

final class WatchTodayTasksProvider
    extends
        $FunctionalProvider<WatchTodayTasks, WatchTodayTasks, WatchTodayTasks>
    with $Provider<WatchTodayTasks> {
  /// Provides the [WatchTodayTasks] use case.
  WatchTodayTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchTodayTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchTodayTasksHash();

  @$internal
  @override
  $ProviderElement<WatchTodayTasks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchTodayTasks create(Ref ref) {
    return watchTodayTasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchTodayTasks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchTodayTasks>(value),
    );
  }
}

String _$watchTodayTasksHash() => r'445cc7e4889681a9a4422589303decd61e012ef1';

/// Provides the [WatchUpcomingTasks] use case.

@ProviderFor(watchUpcomingTasks)
final watchUpcomingTasksProvider = WatchUpcomingTasksProvider._();

/// Provides the [WatchUpcomingTasks] use case.

final class WatchUpcomingTasksProvider
    extends
        $FunctionalProvider<
          WatchUpcomingTasks,
          WatchUpcomingTasks,
          WatchUpcomingTasks
        >
    with $Provider<WatchUpcomingTasks> {
  /// Provides the [WatchUpcomingTasks] use case.
  WatchUpcomingTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchUpcomingTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchUpcomingTasksHash();

  @$internal
  @override
  $ProviderElement<WatchUpcomingTasks> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchUpcomingTasks create(Ref ref) {
    return watchUpcomingTasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchUpcomingTasks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchUpcomingTasks>(value),
    );
  }
}

String _$watchUpcomingTasksHash() =>
    r'9668832e8ca3d1313a2d75f00d876382deeeca62';

/// Provides the [WatchListTasks] use case.

@ProviderFor(watchListTasks)
final watchListTasksProvider = WatchListTasksProvider._();

/// Provides the [WatchListTasks] use case.

final class WatchListTasksProvider
    extends $FunctionalProvider<WatchListTasks, WatchListTasks, WatchListTasks>
    with $Provider<WatchListTasks> {
  /// Provides the [WatchListTasks] use case.
  WatchListTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchListTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchListTasksHash();

  @$internal
  @override
  $ProviderElement<WatchListTasks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchListTasks create(Ref ref) {
    return watchListTasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchListTasks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchListTasks>(value),
    );
  }
}

String _$watchListTasksHash() => r'a1c9ca06048486e5b248980b50ab84921f0316c5';

/// Provides the [WatchSubtasks] use case.

@ProviderFor(watchSubtasks)
final watchSubtasksProvider = WatchSubtasksProvider._();

/// Provides the [WatchSubtasks] use case.

final class WatchSubtasksProvider
    extends $FunctionalProvider<WatchSubtasks, WatchSubtasks, WatchSubtasks>
    with $Provider<WatchSubtasks> {
  /// Provides the [WatchSubtasks] use case.
  WatchSubtasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchSubtasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchSubtasksHash();

  @$internal
  @override
  $ProviderElement<WatchSubtasks> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchSubtasks create(Ref ref) {
    return watchSubtasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchSubtasks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchSubtasks>(value),
    );
  }
}

String _$watchSubtasksHash() => r'93d0a40622b0ed3ababe4db8ba64f495d38d63cd';

/// Provides the [AddSubtask] use case.

@ProviderFor(addSubtask)
final addSubtaskProvider = AddSubtaskProvider._();

/// Provides the [AddSubtask] use case.

final class AddSubtaskProvider
    extends $FunctionalProvider<AddSubtask, AddSubtask, AddSubtask>
    with $Provider<AddSubtask> {
  /// Provides the [AddSubtask] use case.
  AddSubtaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addSubtaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addSubtaskHash();

  @$internal
  @override
  $ProviderElement<AddSubtask> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddSubtask create(Ref ref) {
    return addSubtask(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddSubtask value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddSubtask>(value),
    );
  }
}

String _$addSubtaskHash() => r'a3fbe77726a30115e1ea1fa159844ee29d79760e';

/// Provides the [ToggleSubtask] use case.

@ProviderFor(toggleSubtask)
final toggleSubtaskProvider = ToggleSubtaskProvider._();

/// Provides the [ToggleSubtask] use case.

final class ToggleSubtaskProvider
    extends $FunctionalProvider<ToggleSubtask, ToggleSubtask, ToggleSubtask>
    with $Provider<ToggleSubtask> {
  /// Provides the [ToggleSubtask] use case.
  ToggleSubtaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toggleSubtaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toggleSubtaskHash();

  @$internal
  @override
  $ProviderElement<ToggleSubtask> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ToggleSubtask create(Ref ref) {
    return toggleSubtask(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ToggleSubtask value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ToggleSubtask>(value),
    );
  }
}

String _$toggleSubtaskHash() => r'ffa44284c333b09e04bebbd892bb68994e3aeccf';

/// Provides the [DeleteSubtask] use case.

@ProviderFor(deleteSubtask)
final deleteSubtaskProvider = DeleteSubtaskProvider._();

/// Provides the [DeleteSubtask] use case.

final class DeleteSubtaskProvider
    extends $FunctionalProvider<DeleteSubtask, DeleteSubtask, DeleteSubtask>
    with $Provider<DeleteSubtask> {
  /// Provides the [DeleteSubtask] use case.
  DeleteSubtaskProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteSubtaskProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteSubtaskHash();

  @$internal
  @override
  $ProviderElement<DeleteSubtask> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeleteSubtask create(Ref ref) {
    return deleteSubtask(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteSubtask value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteSubtask>(value),
    );
  }
}

String _$deleteSubtaskHash() => r'1c6b22be94039419ceea570926831334bd1b04af';

/// Provides the [WatchTaskLists] use case.

@ProviderFor(watchTaskLists)
final watchTaskListsProvider = WatchTaskListsProvider._();

/// Provides the [WatchTaskLists] use case.

final class WatchTaskListsProvider
    extends $FunctionalProvider<WatchTaskLists, WatchTaskLists, WatchTaskLists>
    with $Provider<WatchTaskLists> {
  /// Provides the [WatchTaskLists] use case.
  WatchTaskListsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchTaskListsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchTaskListsHash();

  @$internal
  @override
  $ProviderElement<WatchTaskLists> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchTaskLists create(Ref ref) {
    return watchTaskLists(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchTaskLists value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchTaskLists>(value),
    );
  }
}

String _$watchTaskListsHash() => r'47cbd8bf5011d7bbd58e54f2d3be170562aa5d51';

/// Provides the [CreateTaskList] use case.

@ProviderFor(createTaskList)
final createTaskListProvider = CreateTaskListProvider._();

/// Provides the [CreateTaskList] use case.

final class CreateTaskListProvider
    extends $FunctionalProvider<CreateTaskList, CreateTaskList, CreateTaskList>
    with $Provider<CreateTaskList> {
  /// Provides the [CreateTaskList] use case.
  CreateTaskListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTaskListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTaskListHash();

  @$internal
  @override
  $ProviderElement<CreateTaskList> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreateTaskList create(Ref ref) {
    return createTaskList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateTaskList value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateTaskList>(value),
    );
  }
}

String _$createTaskListHash() => r'49b679754aa6a4a1a04025154e86a4f89150cb29';

/// Provides the [SetTaskReminder] use case.

@ProviderFor(setTaskReminder)
final setTaskReminderProvider = SetTaskReminderProvider._();

/// Provides the [SetTaskReminder] use case.

final class SetTaskReminderProvider
    extends
        $FunctionalProvider<SetTaskReminder, SetTaskReminder, SetTaskReminder>
    with $Provider<SetTaskReminder> {
  /// Provides the [SetTaskReminder] use case.
  SetTaskReminderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setTaskReminderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setTaskReminderHash();

  @$internal
  @override
  $ProviderElement<SetTaskReminder> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SetTaskReminder create(Ref ref) {
    return setTaskReminder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetTaskReminder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetTaskReminder>(value),
    );
  }
}

String _$setTaskReminderHash() => r'21f655b94e10d7493efe84404befe48c304d3cec';

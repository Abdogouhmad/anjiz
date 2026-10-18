// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the task repository implementation.

@ProviderFor(taskRepository)
final taskRepositoryProvider = TaskRepositoryProvider._();

/// Provides the task repository implementation.

final class TaskRepositoryProvider
    extends $FunctionalProvider<TaskRepository, TaskRepository, TaskRepository>
    with $Provider<TaskRepository> {
  /// Provides the task repository implementation.
  TaskRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskRepositoryHash();

  @$internal
  @override
  $ProviderElement<TaskRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskRepository create(Ref ref) {
    return taskRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskRepository>(value),
    );
  }
}

String _$taskRepositoryHash() => r'2e1d678bae97688719310aa5c1e8081c9d42f382';

/// Provides the task-list repository implementation.

@ProviderFor(taskListRepository)
final taskListRepositoryProvider = TaskListRepositoryProvider._();

/// Provides the task-list repository implementation.

final class TaskListRepositoryProvider
    extends
        $FunctionalProvider<
          TaskListRepository,
          TaskListRepository,
          TaskListRepository
        >
    with $Provider<TaskListRepository> {
  /// Provides the task-list repository implementation.
  TaskListRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskListRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskListRepositoryHash();

  @$internal
  @override
  $ProviderElement<TaskListRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TaskListRepository create(Ref ref) {
    return taskListRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskListRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskListRepository>(value),
    );
  }
}

String _$taskListRepositoryHash() =>
    r'7df19e3deebbf07a3e4d773c011ffd7073c0d82e';

/// Provides the subtask repository implementation.

@ProviderFor(subtaskRepository)
final subtaskRepositoryProvider = SubtaskRepositoryProvider._();

/// Provides the subtask repository implementation.

final class SubtaskRepositoryProvider
    extends
        $FunctionalProvider<
          SubtaskRepository,
          SubtaskRepository,
          SubtaskRepository
        >
    with $Provider<SubtaskRepository> {
  /// Provides the subtask repository implementation.
  SubtaskRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subtaskRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subtaskRepositoryHash();

  @$internal
  @override
  $ProviderElement<SubtaskRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SubtaskRepository create(Ref ref) {
    return subtaskRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubtaskRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubtaskRepository>(value),
    );
  }
}

String _$subtaskRepositoryHash() => r'65e3e3da03ae1540becdf053233f660cbede8a2f';

/// Provides the reminder repository implementation.

@ProviderFor(reminderRepository)
final reminderRepositoryProvider = ReminderRepositoryProvider._();

/// Provides the reminder repository implementation.

final class ReminderRepositoryProvider
    extends
        $FunctionalProvider<
          ReminderRepository,
          ReminderRepository,
          ReminderRepository
        >
    with $Provider<ReminderRepository> {
  /// Provides the reminder repository implementation.
  ReminderRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReminderRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReminderRepository create(Ref ref) {
    return reminderRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderRepository>(value),
    );
  }
}

String _$reminderRepositoryHash() =>
    r'5e6c08f8c5ae8066c879cdf13dda3d58acfba675';

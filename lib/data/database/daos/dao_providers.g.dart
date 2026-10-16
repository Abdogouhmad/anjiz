// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dao_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the task DAO.

@ProviderFor(taskDao)
final taskDaoProvider = TaskDaoProvider._();

/// Provides the task DAO.

final class TaskDaoProvider
    extends $FunctionalProvider<TaskDao, TaskDao, TaskDao>
    with $Provider<TaskDao> {
  /// Provides the task DAO.
  TaskDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskDaoHash();

  @$internal
  @override
  $ProviderElement<TaskDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskDao create(Ref ref) {
    return taskDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskDao>(value),
    );
  }
}

String _$taskDaoHash() => r'b08d64091fd61fa59d2b9761164da93cdbe73b4c';

/// Provides the task-list DAO.

@ProviderFor(taskListDao)
final taskListDaoProvider = TaskListDaoProvider._();

/// Provides the task-list DAO.

final class TaskListDaoProvider
    extends $FunctionalProvider<TaskListDao, TaskListDao, TaskListDao>
    with $Provider<TaskListDao> {
  /// Provides the task-list DAO.
  TaskListDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskListDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskListDaoHash();

  @$internal
  @override
  $ProviderElement<TaskListDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskListDao create(Ref ref) {
    return taskListDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskListDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskListDao>(value),
    );
  }
}

String _$taskListDaoHash() => r'1b55c2fb907ea9ff6fb3500b3db36719c0b498f0';

/// Provides the subtask DAO.

@ProviderFor(subtaskDao)
final subtaskDaoProvider = SubtaskDaoProvider._();

/// Provides the subtask DAO.

final class SubtaskDaoProvider
    extends $FunctionalProvider<SubtaskDao, SubtaskDao, SubtaskDao>
    with $Provider<SubtaskDao> {
  /// Provides the subtask DAO.
  SubtaskDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subtaskDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subtaskDaoHash();

  @$internal
  @override
  $ProviderElement<SubtaskDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SubtaskDao create(Ref ref) {
    return subtaskDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubtaskDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubtaskDao>(value),
    );
  }
}

String _$subtaskDaoHash() => r'75990d3cc26acc37314e5049799e70be75df5ed0';

/// Provides the reminder DAO.

@ProviderFor(reminderDao)
final reminderDaoProvider = ReminderDaoProvider._();

/// Provides the reminder DAO.

final class ReminderDaoProvider
    extends $FunctionalProvider<ReminderDao, ReminderDao, ReminderDao>
    with $Provider<ReminderDao> {
  /// Provides the reminder DAO.
  ReminderDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reminderDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reminderDaoHash();

  @$internal
  @override
  $ProviderElement<ReminderDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReminderDao create(Ref ref) {
    return reminderDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReminderDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReminderDao>(value),
    );
  }
}

String _$reminderDaoHash() => r'ce8776a728d640f5484051ebaa80bbd756942276';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_queries.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Streams every task list ordered by manual sort position.

@ProviderFor(taskLists)
final taskListsProvider = TaskListsProvider._();

/// Streams every task list ordered by manual sort position.

final class TaskListsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TaskList>>,
          List<TaskList>,
          Stream<List<TaskList>>
        >
    with $FutureModifier<List<TaskList>>, $StreamProvider<List<TaskList>> {
  /// Streams every task list ordered by manual sort position.
  TaskListsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskListsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskListsHash();

  @$internal
  @override
  $StreamProviderElement<List<TaskList>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TaskList>> create(Ref ref) {
    return taskLists(ref);
  }
}

String _$taskListsHash() => r'd447f158f2f42075c07a39b002fb4eda0fa79fc5';

/// Streams every task (used for cross-list summaries and search).

@ProviderFor(allTasks)
final allTasksProvider = AllTasksProvider._();

/// Streams every task (used for cross-list summaries and search).

final class AllTasksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Task>>,
          List<Task>,
          Stream<List<Task>>
        >
    with $FutureModifier<List<Task>>, $StreamProvider<List<Task>> {
  /// Streams every task (used for cross-list summaries and search).
  AllTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allTasksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allTasksHash();

  @$internal
  @override
  $StreamProviderElement<List<Task>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Task>> create(Ref ref) {
    return allTasks(ref);
  }
}

String _$allTasksHash() => r'd88bba62b0b7070462c4a2ee2fa06e9a024c9ad7';

/// Streams the tasks belonging to [listId].

@ProviderFor(listTasks)
final listTasksProvider = ListTasksFamily._();

/// Streams the tasks belonging to [listId].

final class ListTasksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Task>>,
          List<Task>,
          Stream<List<Task>>
        >
    with $FutureModifier<List<Task>>, $StreamProvider<List<Task>> {
  /// Streams the tasks belonging to [listId].
  ListTasksProvider._({
    required ListTasksFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'listTasksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$listTasksHash();

  @override
  String toString() {
    return r'listTasksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Task>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Task>> create(Ref ref) {
    final argument = this.argument as String;
    return listTasks(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ListTasksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listTasksHash() => r'e7a2c6e01a3ff39c4b6bbaf178647bb9e57043a8';

/// Streams the tasks belonging to [listId].

final class ListTasksFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Task>>, String> {
  ListTasksFamily._()
    : super(
        retry: null,
        name: r'listTasksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Streams the tasks belonging to [listId].

  ListTasksProvider call(String listId) =>
      ListTasksProvider._(argument: listId, from: this);

  @override
  String toString() => r'listTasksProvider';
}

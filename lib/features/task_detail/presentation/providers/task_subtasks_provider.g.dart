// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_subtasks_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Streams the checklist items belonging to [taskId].

@ProviderFor(taskSubtasks)
final taskSubtasksProvider = TaskSubtasksFamily._();

/// Streams the checklist items belonging to [taskId].

final class TaskSubtasksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Subtask>>,
          List<Subtask>,
          Stream<List<Subtask>>
        >
    with $FutureModifier<List<Subtask>>, $StreamProvider<List<Subtask>> {
  /// Streams the checklist items belonging to [taskId].
  TaskSubtasksProvider._({
    required TaskSubtasksFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'taskSubtasksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$taskSubtasksHash();

  @override
  String toString() {
    return r'taskSubtasksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Subtask>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Subtask>> create(Ref ref) {
    final argument = this.argument as String;
    return taskSubtasks(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskSubtasksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$taskSubtasksHash() => r'3cdd7a6700440c283a677c65d00479e7e494f50e';

/// Streams the checklist items belonging to [taskId].

final class TaskSubtasksFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Subtask>>, String> {
  TaskSubtasksFamily._()
    : super(
        retry: null,
        name: r'taskSubtasksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Streams the checklist items belonging to [taskId].

  TaskSubtasksProvider call(String taskId) =>
      TaskSubtasksProvider._(argument: taskId, from: this);

  @override
  String toString() => r'taskSubtasksProvider';
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_reminders_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Streams the scheduled reminders bound to [taskId].

@ProviderFor(taskReminders)
final taskRemindersProvider = TaskRemindersFamily._();

/// Streams the scheduled reminders bound to [taskId].

final class TaskRemindersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Reminder>>,
          List<Reminder>,
          Stream<List<Reminder>>
        >
    with $FutureModifier<List<Reminder>>, $StreamProvider<List<Reminder>> {
  /// Streams the scheduled reminders bound to [taskId].
  TaskRemindersProvider._({
    required TaskRemindersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'taskRemindersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$taskRemindersHash();

  @override
  String toString() {
    return r'taskRemindersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Reminder>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Reminder>> create(Ref ref) {
    final argument = this.argument as String;
    return taskReminders(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskRemindersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$taskRemindersHash() => r'38e5786749e2ef193c97c87c9175f6adefed4ea1';

/// Streams the scheduled reminders bound to [taskId].

final class TaskRemindersFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Reminder>>, String> {
  TaskRemindersFamily._()
    : super(
        retry: null,
        name: r'taskRemindersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Streams the scheduled reminders bound to [taskId].

  TaskRemindersProvider call(String taskId) =>
      TaskRemindersProvider._(argument: taskId, from: this);

  @override
  String toString() => r'taskRemindersProvider';
}

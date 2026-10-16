// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_by_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Streams a single task by id, or `null` when it no longer exists.

@ProviderFor(taskById)
final taskByIdProvider = TaskByIdFamily._();

/// Streams a single task by id, or `null` when it no longer exists.

final class TaskByIdProvider
    extends $FunctionalProvider<AsyncValue<Task?>, Task?, Stream<Task?>>
    with $FutureModifier<Task?>, $StreamProvider<Task?> {
  /// Streams a single task by id, or `null` when it no longer exists.
  TaskByIdProvider._({
    required TaskByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'taskByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$taskByIdHash();

  @override
  String toString() {
    return r'taskByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Task?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Task?> create(Ref ref) {
    final argument = this.argument as String;
    return taskById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$taskByIdHash() => r'a3d6254d111a5fcf6e4f53d467209b50652c2263';

/// Streams a single task by id, or `null` when it no longer exists.

final class TaskByIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Task?>, String> {
  TaskByIdFamily._()
    : super(
        retry: null,
        name: r'taskByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Streams a single task by id, or `null` when it no longer exists.

  TaskByIdProvider call(String id) =>
      TaskByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'taskByIdProvider';
}

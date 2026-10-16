// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_actions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the shared [TaskActions].

@ProviderFor(taskActions)
final taskActionsProvider = TaskActionsProvider._();

/// Provides the shared [TaskActions].

final class TaskActionsProvider
    extends $FunctionalProvider<TaskActions, TaskActions, TaskActions>
    with $Provider<TaskActions> {
  /// Provides the shared [TaskActions].
  TaskActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskActionsHash();

  @$internal
  @override
  $ProviderElement<TaskActions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskActions create(Ref ref) {
    return taskActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskActions>(value),
    );
  }
}

String _$taskActionsHash() => r'f1dcd86d31e9ab11ffb88bae0658d13b43796956';

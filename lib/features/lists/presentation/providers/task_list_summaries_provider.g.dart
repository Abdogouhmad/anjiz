// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_summaries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Derives each list together with its remaining/completed counts from the
/// live task queries.

@ProviderFor(taskListSummaries)
final taskListSummariesProvider = TaskListSummariesProvider._();

/// Derives each list together with its remaining/completed counts from the
/// live task queries.

final class TaskListSummariesProvider
    extends
        $FunctionalProvider<
          List<TaskListSummary>,
          List<TaskListSummary>,
          List<TaskListSummary>
        >
    with $Provider<List<TaskListSummary>> {
  /// Derives each list together with its remaining/completed counts from the
  /// live task queries.
  TaskListSummariesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'taskListSummariesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$taskListSummariesHash();

  @$internal
  @override
  $ProviderElement<List<TaskListSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TaskListSummary> create(Ref ref) {
    return taskListSummaries(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TaskListSummary> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TaskListSummary>>(value),
    );
  }
}

String _$taskListSummariesHash() => r'3925518633dd91d538a016a1ad8f4fd38b88012e';

/// The total number of open tasks across every list.

@ProviderFor(activeTaskCount)
final activeTaskCountProvider = ActiveTaskCountProvider._();

/// The total number of open tasks across every list.

final class ActiveTaskCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// The total number of open tasks across every list.
  ActiveTaskCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeTaskCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeTaskCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return activeTaskCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$activeTaskCountHash() => r'52e553b617eee2e48364afff3f9ef6074d73883e';

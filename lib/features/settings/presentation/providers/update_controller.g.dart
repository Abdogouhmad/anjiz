// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns the over-the-air update state machine: when to check, which release is
/// being offered, and how far a download has got.

@ProviderFor(UpdateController)
final updateControllerProvider = UpdateControllerProvider._();

/// Owns the over-the-air update state machine: when to check, which release is
/// being offered, and how far a download has got.
final class UpdateControllerProvider
    extends $NotifierProvider<UpdateController, UpdateStatus> {
  /// Owns the over-the-air update state machine: when to check, which release is
  /// being offered, and how far a download has got.
  UpdateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateControllerHash();

  @$internal
  @override
  UpdateController create() => UpdateController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateStatus>(value),
    );
  }
}

String _$updateControllerHash() => r'2aa26c6d6d606d4c2b16d03a6b0eea8034541e7c';

/// Owns the over-the-air update state machine: when to check, which release is
/// being offered, and how far a download has got.

abstract class _$UpdateController extends $Notifier<UpdateStatus> {
  UpdateStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<UpdateStatus, UpdateStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UpdateStatus, UpdateStatus>,
              UpdateStatus,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

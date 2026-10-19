// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'haptic_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The persisted haptic intensity (0 off, 1 subtle, 2 expressive).
///
/// Read synchronously from [sharedPreferencesProvider] so the level is known
/// before the first frame; invalidate after writing the preference.

@ProviderFor(hapticLevel)
final hapticLevelProvider = HapticLevelProvider._();

/// The persisted haptic intensity (0 off, 1 subtle, 2 expressive).
///
/// Read synchronously from [sharedPreferencesProvider] so the level is known
/// before the first frame; invalidate after writing the preference.

final class HapticLevelProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// The persisted haptic intensity (0 off, 1 subtle, 2 expressive).
  ///
  /// Read synchronously from [sharedPreferencesProvider] so the level is known
  /// before the first frame; invalidate after writing the preference.
  HapticLevelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hapticLevelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hapticLevelHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return hapticLevel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$hapticLevelHash() => r'e58f7b223944f84c5d393b4158a2eba57093efbb';

/// Provides the app-wide [HapticService].
///
/// Read once during bootstrap so the component-level `AnjizHaptics` facade is
/// configured with the persisted level before the first interactive frame.

@ProviderFor(hapticService)
final hapticServiceProvider = HapticServiceProvider._();

/// Provides the app-wide [HapticService].
///
/// Read once during bootstrap so the component-level `AnjizHaptics` facade is
/// configured with the persisted level before the first interactive frame.

final class HapticServiceProvider
    extends $FunctionalProvider<HapticService, HapticService, HapticService>
    with $Provider<HapticService> {
  /// Provides the app-wide [HapticService].
  ///
  /// Read once during bootstrap so the component-level `AnjizHaptics` facade is
  /// configured with the persisted level before the first interactive frame.
  HapticServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hapticServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hapticServiceHash();

  @$internal
  @override
  $ProviderElement<HapticService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HapticService create(Ref ref) {
    return hapticService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HapticService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HapticService>(value),
    );
  }
}

String _$hapticServiceHash() => r'db5bc57ff02e408fb25f1af788dc2dcd0fb3fdba';

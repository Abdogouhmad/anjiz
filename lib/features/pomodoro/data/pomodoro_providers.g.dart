// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the singleton [PomodoroChannel], attached and listening for
/// native events for the lifetime of the app.

@ProviderFor(pomodoroChannel)
final pomodoroChannelProvider = PomodoroChannelProvider._();

/// Provides the singleton [PomodoroChannel], attached and listening for
/// native events for the lifetime of the app.

final class PomodoroChannelProvider
    extends
        $FunctionalProvider<PomodoroChannel, PomodoroChannel, PomodoroChannel>
    with $Provider<PomodoroChannel> {
  /// Provides the singleton [PomodoroChannel], attached and listening for
  /// native events for the lifetime of the app.
  PomodoroChannelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pomodoroChannelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pomodoroChannelHash();

  @$internal
  @override
  $ProviderElement<PomodoroChannel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PomodoroChannel create(Ref ref) {
    return pomodoroChannel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PomodoroChannel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PomodoroChannel>(value),
    );
  }
}

String _$pomodoroChannelHash() => r'c7227cdb548d791acc92723b702729baf0f5b75b';

/// What this device can do with the focus timer.
///
/// Never throws: a missing native plugin (desktop, tests) reads as
/// [PomodoroAvailability.unsupported] so the UI can degrade quietly.

@ProviderFor(pomodoroAvailability)
final pomodoroAvailabilityProvider = PomodoroAvailabilityProvider._();

/// What this device can do with the focus timer.
///
/// Never throws: a missing native plugin (desktop, tests) reads as
/// [PomodoroAvailability.unsupported] so the UI can degrade quietly.

final class PomodoroAvailabilityProvider
    extends
        $FunctionalProvider<
          AsyncValue<PomodoroAvailability>,
          PomodoroAvailability,
          FutureOr<PomodoroAvailability>
        >
    with
        $FutureModifier<PomodoroAvailability>,
        $FutureProvider<PomodoroAvailability> {
  /// What this device can do with the focus timer.
  ///
  /// Never throws: a missing native plugin (desktop, tests) reads as
  /// [PomodoroAvailability.unsupported] so the UI can degrade quietly.
  PomodoroAvailabilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pomodoroAvailabilityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pomodoroAvailabilityHash();

  @$internal
  @override
  $FutureProviderElement<PomodoroAvailability> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PomodoroAvailability> create(Ref ref) {
    return pomodoroAvailability(ref);
  }
}

String _$pomodoroAvailabilityHash() =>
    r'8beb0b174c1a778a1ba973853ebe8692629d0838';

/// Whether the focus timer can be started on this device right now.
///
/// False while the native capability check is still in flight, so entry points
/// render disabled rather than flashing an enabled control.

@ProviderFor(pomodoroSupported)
final pomodoroSupportedProvider = PomodoroSupportedProvider._();

/// Whether the focus timer can be started on this device right now.
///
/// False while the native capability check is still in flight, so entry points
/// render disabled rather than flashing an enabled control.

final class PomodoroSupportedProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Whether the focus timer can be started on this device right now.
  ///
  /// False while the native capability check is still in flight, so entry points
  /// render disabled rather than flashing an enabled control.
  PomodoroSupportedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pomodoroSupportedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pomodoroSupportedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return pomodoroSupported(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$pomodoroSupportedHash() => r'ca3085ee82777d8bae4e4989c09c1b54c7dc8f5c';

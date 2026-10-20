// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors the persisted focus settings into the Pomodoro feature's value
/// object, so the feature never imports the settings feature directly.

@ProviderFor(pomodoroConfig)
final pomodoroConfigProvider = PomodoroConfigProvider._();

/// Mirrors the persisted focus settings into the Pomodoro feature's value
/// object, so the feature never imports the settings feature directly.

final class PomodoroConfigProvider
    extends $FunctionalProvider<PomodoroConfig, PomodoroConfig, PomodoroConfig>
    with $Provider<PomodoroConfig> {
  /// Mirrors the persisted focus settings into the Pomodoro feature's value
  /// object, so the feature never imports the settings feature directly.
  PomodoroConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pomodoroConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pomodoroConfigHash();

  @$internal
  @override
  $ProviderElement<PomodoroConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PomodoroConfig create(Ref ref) {
    return pomodoroConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PomodoroConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PomodoroConfig>(value),
    );
  }
}

String _$pomodoroConfigHash() => r'4d72d506dad96bf8327cd7dcedf22dd7d658a443';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mirrors the native focus timer and applies the domain side effects Dart owns.
///
/// The foreground service is the single clock: this notifier only listens to
/// its events, logs a focus session when a focus phase ends, and completes the
/// task when the notification's "Done" action fires.

@ProviderFor(PomodoroController)
final pomodoroControllerProvider = PomodoroControllerProvider._();

/// Mirrors the native focus timer and applies the domain side effects Dart owns.
///
/// The foreground service is the single clock: this notifier only listens to
/// its events, logs a focus session when a focus phase ends, and completes the
/// task when the notification's "Done" action fires.
final class PomodoroControllerProvider
    extends $NotifierProvider<PomodoroController, PomodoroRun?> {
  /// Mirrors the native focus timer and applies the domain side effects Dart owns.
  ///
  /// The foreground service is the single clock: this notifier only listens to
  /// its events, logs a focus session when a focus phase ends, and completes the
  /// task when the notification's "Done" action fires.
  PomodoroControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pomodoroControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pomodoroControllerHash();

  @$internal
  @override
  PomodoroController create() => PomodoroController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PomodoroRun? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PomodoroRun?>(value),
    );
  }
}

String _$pomodoroControllerHash() =>
    r'990072e5932e4881748ce284b13c5b1d6b44c9a5';

/// Mirrors the native focus timer and applies the domain side effects Dart owns.
///
/// The foreground service is the single clock: this notifier only listens to
/// its events, logs a focus session when a focus phase ends, and completes the
/// task when the notification's "Done" action fires.

abstract class _$PomodoroController extends $Notifier<PomodoroRun?> {
  PomodoroRun? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PomodoroRun?, PomodoroRun?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PomodoroRun?, PomodoroRun?>,
              PomodoroRun?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

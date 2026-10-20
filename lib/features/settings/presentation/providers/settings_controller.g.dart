// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns the persisted [AppSettings], reading them synchronously from
/// [sharedPreferencesProvider].

@ProviderFor(SettingsController)
final settingsControllerProvider = SettingsControllerProvider._();

/// Owns the persisted [AppSettings], reading them synchronously from
/// [sharedPreferencesProvider].
final class SettingsControllerProvider
    extends $NotifierProvider<SettingsController, AppSettings> {
  /// Owns the persisted [AppSettings], reading them synchronously from
  /// [sharedPreferencesProvider].
  SettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSettings>(value),
    );
  }
}

String _$settingsControllerHash() =>
    r'2b3b9392b5766811fe5c6696e6a336ba3abe2e5f';

/// Owns the persisted [AppSettings], reading them synchronously from
/// [sharedPreferencesProvider].

abstract class _$SettingsController extends $Notifier<AppSettings> {
  AppSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppSettings, AppSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppSettings, AppSettings>,
              AppSettings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

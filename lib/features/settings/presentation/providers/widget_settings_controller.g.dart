// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns the persisted widget configuration read from shared preferences.

@ProviderFor(WidgetSettingsController)
final widgetSettingsControllerProvider = WidgetSettingsControllerProvider._();

/// Owns the persisted widget configuration read from shared preferences.
final class WidgetSettingsControllerProvider
    extends $NotifierProvider<WidgetSettingsController, WidgetSettings> {
  /// Owns the persisted widget configuration read from shared preferences.
  WidgetSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'widgetSettingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$widgetSettingsControllerHash();

  @$internal
  @override
  WidgetSettingsController create() => WidgetSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WidgetSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WidgetSettings>(value),
    );
  }
}

String _$widgetSettingsControllerHash() =>
    r'942d9e983cec3dda0ab589ceca4110275ca55561';

/// Owns the persisted widget configuration read from shared preferences.

abstract class _$WidgetSettingsController extends $Notifier<WidgetSettings> {
  WidgetSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<WidgetSettings, WidgetSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WidgetSettings, WidgetSettings>,
              WidgetSettings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

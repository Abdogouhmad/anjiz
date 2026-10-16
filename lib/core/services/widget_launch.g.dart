// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_launch.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Streams the deep links emitted when a home-screen widget is tapped,
/// including the link the app was cold-started with.
///
/// The shell listens to this to open the quick-add composer.

@ProviderFor(widgetLaunches)
final widgetLaunchesProvider = WidgetLaunchesProvider._();

/// Streams the deep links emitted when a home-screen widget is tapped,
/// including the link the app was cold-started with.
///
/// The shell listens to this to open the quick-add composer.

final class WidgetLaunchesProvider
    extends $FunctionalProvider<AsyncValue<Uri?>, Uri?, Stream<Uri?>>
    with $FutureModifier<Uri?>, $StreamProvider<Uri?> {
  /// Streams the deep links emitted when a home-screen widget is tapped,
  /// including the link the app was cold-started with.
  ///
  /// The shell listens to this to open the quick-add composer.
  WidgetLaunchesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'widgetLaunchesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$widgetLaunchesHash();

  @$internal
  @override
  $StreamProviderElement<Uri?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Uri?> create(Ref ref) {
    return widgetLaunches(ref);
  }
}

String _$widgetLaunchesHash() => r'70de8c8928d8888a86fccd8c0ae805574813ad79';

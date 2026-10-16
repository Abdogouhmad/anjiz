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
/// The shell listens to this to open the quick-add composer. Empty on platforms
/// without home-screen widgets.

@ProviderFor(widgetLaunches)
final widgetLaunchesProvider = WidgetLaunchesProvider._();

/// Streams the deep links emitted when a home-screen widget is tapped,
/// including the link the app was cold-started with.
///
/// The shell listens to this to open the quick-add composer. Empty on platforms
/// without home-screen widgets.

final class WidgetLaunchesProvider
    extends $FunctionalProvider<AsyncValue<Uri?>, Uri?, Stream<Uri?>>
    with $FutureModifier<Uri?>, $StreamProvider<Uri?> {
  /// Streams the deep links emitted when a home-screen widget is tapped,
  /// including the link the app was cold-started with.
  ///
  /// The shell listens to this to open the quick-add composer. Empty on platforms
  /// without home-screen widgets.
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

String _$widgetLaunchesHash() => r'da4713bb0628a307530a2b126ee1ffd21aceb58b';

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
///
/// Each tap is emitted as-is (no de-duplication): a cold start delivers its
/// link through [HomeWidget.initiallyLaunchedFromHomeWidget] while a running
/// app receives fresh taps through [HomeWidget.widgetClicked], and the two
/// never fire for the same physical tap. De-duplicating here would swallow the
/// second and later taps of the same widget (identical URI), so the composer
/// would fail to reopen.

@ProviderFor(widgetLaunches)
final widgetLaunchesProvider = WidgetLaunchesProvider._();

/// Streams the deep links emitted when a home-screen widget is tapped,
/// including the link the app was cold-started with.
///
/// The shell listens to this to open the quick-add composer. Empty on platforms
/// without home-screen widgets.
///
/// Each tap is emitted as-is (no de-duplication): a cold start delivers its
/// link through [HomeWidget.initiallyLaunchedFromHomeWidget] while a running
/// app receives fresh taps through [HomeWidget.widgetClicked], and the two
/// never fire for the same physical tap. De-duplicating here would swallow the
/// second and later taps of the same widget (identical URI), so the composer
/// would fail to reopen.

final class WidgetLaunchesProvider
    extends $FunctionalProvider<AsyncValue<Uri?>, Uri?, Stream<Uri?>>
    with $FutureModifier<Uri?>, $StreamProvider<Uri?> {
  /// Streams the deep links emitted when a home-screen widget is tapped,
  /// including the link the app was cold-started with.
  ///
  /// The shell listens to this to open the quick-add composer. Empty on platforms
  /// without home-screen widgets.
  ///
  /// Each tap is emitted as-is (no de-duplication): a cold start delivers its
  /// link through [HomeWidget.initiallyLaunchedFromHomeWidget] while a running
  /// app receives fresh taps through [HomeWidget.widgetClicked], and the two
  /// never fire for the same physical tap. De-duplicating here would swallow the
  /// second and later taps of the same widget (identical URI), so the composer
  /// would fail to reopen.
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

String _$widgetLaunchesHash() => r'2477b0ef1f61745b9543b053ba84b40aa6305f76';

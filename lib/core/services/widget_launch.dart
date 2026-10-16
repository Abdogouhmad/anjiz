import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/platform_support.dart';

part 'widget_launch.g.dart';

/// Streams the deep links emitted when a home-screen widget is tapped,
/// including the link the app was cold-started with.
///
/// The shell listens to this to open the quick-add composer. Empty on platforms
/// without home-screen widgets.
@Riverpod(keepAlive: true)
Stream<Uri?> widgetLaunches(Ref ref) async* {
  if (!PlatformSupport.homeWidgets) return;
  Uri? last;
  final initial = await HomeWidget.initiallyLaunchedFromHomeWidget();
  if (initial != null) {
    last = initial;
    yield initial;
  }
  await for (final uri in HomeWidget.widgetClicked) {
    if (uri == null || uri == last) continue;
    last = uri;
    yield uri;
  }
}

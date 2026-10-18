import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/platform_support.dart';

part 'widget_launch.g.dart';

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
@Riverpod(keepAlive: true)
Stream<Uri?> widgetLaunches(Ref ref) async* {
  if (!PlatformSupport.homeWidgets) return;
  final initial = await HomeWidget.initiallyLaunchedFromHomeWidget();
  if (initial != null) yield initial;
  await for (final uri in HomeWidget.widgetClicked) {
    if (uri != null) yield uri;
  }
}

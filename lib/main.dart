import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';
import 'app/widget_background.dart';

/// Application entry point.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerWidgetBackgroundCallback();
  final container = await bootstrap();
  runApp(
    UncontrolledProviderScope(container: container, child: const AnjizApp()),
  );
}

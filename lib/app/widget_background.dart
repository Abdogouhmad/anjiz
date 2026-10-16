import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/app_constants.dart';
import '../core/services/preferences_provider.dart';
import '../core/services/service_providers.dart';
import '../data/repositories/repository_providers.dart';
import 'providers/use_case_providers.dart';

/// Registers the background entry point invoked by home-screen widget taps.
///
/// Call once, before `runApp`.
Future<void> registerWidgetBackgroundCallback() =>
    HomeWidget.registerInteractivityCallback(anjizWidgetCallback);

/// Handles interactive widget taps in a lightweight background isolate.
///
/// Registered with `home_widget`; [uri] carries the tapped action (for example
/// `anjiz://task/toggle?id=…`). The DB is opened, the task mutated and the
/// widget snapshot re-pushed. Failures are swallowed so a broken tap can never
/// crash the host launcher.
@pragma('vm:entry-point')
Future<void> anjizWidgetCallback(Uri? uri) async {
  if (uri == null) return;
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
  );
  try {
    await _apply(container, uri);
  } on Object {
    // Best-effort: the tap may race with a fresh install.
  } finally {
    await container.read(widgetSyncServiceProvider).sync();
    container.dispose();
  }
}

Future<void> _apply(ProviderContainer container, Uri uri) async {
  if (uri.host != AppConstants.widgetTaskHost) return;
  final taskId = uri.queryParameters[AppConstants.widgetTaskIdParam];
  if (taskId == null) return;
  final task = await container.read(taskRepositoryProvider).findById(taskId);
  if (task == null) return;
  switch (uri.path) {
    case '/toggle':
      await container.read(toggleTaskDoneProvider)(task, isDone: !task.isDone);
    case '/star':
      await container.read(toggleTaskStarProvider)(
        task,
        isStarred: !task.isStarred,
      );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../data/repositories/repository_providers.dart';
import '../constants/app_constants.dart';
import '../utils/platform_support.dart';
import 'daily_briefing.dart';
import 'preferences_provider.dart';
import 'reminder_resync.dart';
import 'widget_sync_service.dart';

/// Registers the WorkManager job that keeps widgets and reminders fresh.
///
/// Runs on every launch; re-registering with `ExistingPeriodicWorkPolicy.keep`
/// is idempotent, so the job survives even when the app is never opened again
/// after a reboot (WorkManager restores it automatically). No-op on platforms
/// without WorkManager support (e.g. desktop).
class BackgroundRefreshScheduler {
  /// Initialises WorkManager and registers the recurring refresh job.
  Future<void> schedule() async {
    if (!PlatformSupport.backgroundWork) return;
    await Workmanager().initialize(backgroundRefreshDispatcher);
    await Workmanager().registerPeriodicTask(
      AppConstants.workMidnightRefresh,
      AppConstants.workMidnightRefresh,
      frequency: const Duration(hours: 6),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    );
  }
}

/// WorkManager entry point. Runs in a background isolate.
@pragma('vm:entry-point')
void backgroundRefreshDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == AppConstants.workMidnightRefresh) {
      await runBackgroundRefresh();
    }
    return true;
  });
}

/// Re-pushes the widget snapshot and rebuilds pending reminders.
///
/// The OS clears scheduled notifications on reboot and the widget copy goes
/// stale at the day boundary, so both are refreshed from the database here.
Future<void> runBackgroundRefresh() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
  );
  try {
    await reschedulePendingReminders(container);
    await reconcileDailyBriefing(container);
    await WidgetSyncService(
      container.read(taskRepositoryProvider),
      container.read(taskListRepositoryProvider),
      preferences,
    ).sync();
  } on Object {
    // Best-effort: a failed background pass must not fail the worker.
  } finally {
    container.dispose();
  }
}

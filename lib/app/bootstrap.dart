import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/app_info.dart';
import '../core/services/background_refresh.dart';
import '../core/services/daily_briefing.dart';
import '../core/services/preferences_provider.dart';
import '../core/services/service_providers.dart';
import '../data/repositories/repository_providers.dart';
import '../features/settings/presentation/providers/update_controller.dart';
import '../l10n/app_localizations.dart';
import 'router.dart';

/// Wires the long-lived platform services and returns the app container.
///
/// Called once from `main.dart` before the first frame: resolves preferences,
/// reads the installed build's version, initialises notifications, guarantees
/// the default list exists, pushes the initial home-screen widget snapshot and
/// registers the recurring background refresh job.
Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
  );
  await AppInfo.init();
  final l10n = await AppLocalizations.delegate.load(const Locale('en'));
  await container.read(notificationServiceProvider).init(l10n);
  // Re-register the daily briefing so it survives reboots and upgrades.
  await reconcileDailyBriefing(container);
  await container
      .read(taskListRepositoryProvider)
      .ensureDefault(l10n.defaultListName);
  await container.read(widgetSyncServiceProvider).sync();
  await BackgroundRefreshScheduler().schedule();
  // Look for a newer release in the background: it never blocks the first
  // frame, never fails loudly, and rate-limits itself internally.
  unawaited(container.read(updateControllerProvider.notifier).autoCheck());
  // Eagerly build the router so its redirect sees the resolved settings.
  container.read(routerProvider);
  return container;
}

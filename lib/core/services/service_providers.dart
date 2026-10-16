import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/repository_providers.dart';
import 'notification_service.dart';
import 'preferences_provider.dart';
import 'update_service.dart';
import 'widget_sync_service.dart';

part 'service_providers.g.dart';

/// Provides the notification service singleton.
@Riverpod(keepAlive: true)
NotificationService notificationService(Ref ref) => NotificationService();

/// Provides the over-the-air update service singleton.
@Riverpod(keepAlive: true)
UpdateService updateService(Ref ref) {
  final service = UpdateService();
  ref.onDispose(service.dispose);
  return service;
}

/// Provides the home-widget sync service singleton.
@Riverpod(keepAlive: true)
WidgetSyncService widgetSyncService(Ref ref) => WidgetSyncService(
  ref.watch(taskRepositoryProvider),
  ref.watch(taskListRepositoryProvider),
  ref.watch(sharedPreferencesProvider),
);

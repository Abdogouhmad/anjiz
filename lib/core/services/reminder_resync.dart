import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/repository_providers.dart';
import '../../domain/usecases/set_task_reminder.dart';
import '../../l10n/app_localizations.dart';
import '../utils/platform_support.dart';
import 'service_providers.dart';

/// Re-schedules every pending reminder from the database.
///
/// Android drops alarms on reboot, app updates and OEM battery kills, so the
/// reminder rows are the source of truth and the alarms are rebuilt from them:
/// on every app start (bootstrap) and from the WorkManager refresh job.
///
/// No-op on platforms without notification support.
Future<void> reschedulePendingReminders(ProviderContainer container) async {
  if (!PlatformSupport.notifications) return;
  final reminderRepo = container.read(reminderRepositoryProvider);
  final reminders = await reminderRepo.findAll();
  if (reminders.isEmpty) return;
  final notifications = container.read(notificationServiceProvider);
  final l10n = await AppLocalizations.delegate.load(const Locale('en'));
  await notifications.init(l10n);
  final schedule = SetTaskReminder(
    reminders: reminderRepo,
    scheduler: notifications,
  );
  final tasks = container.read(taskRepositoryProvider);
  for (final reminder in reminders) {
    final task = await tasks.findById(reminder.taskId);
    if (task == null || task.isDone || task.dueAt == null) continue;
    await schedule.schedule(
      task,
      title: task.title,
      body: task.notes.isEmpty ? task.title : task.notes,
    );
  }
}

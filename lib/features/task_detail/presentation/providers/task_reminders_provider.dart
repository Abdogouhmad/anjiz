import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/repository_providers.dart';
import '../../../../domain/entities/reminder.dart';

part 'task_reminders_provider.g.dart';

/// Streams the scheduled reminders bound to [taskId].
@riverpod
Stream<List<Reminder>> taskReminders(Ref ref, String taskId) =>
    ref.watch(reminderRepositoryProvider).watchForTask(taskId);

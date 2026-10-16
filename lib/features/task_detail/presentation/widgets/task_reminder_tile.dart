import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/use_case_providers.dart';
import '../../../../core/services/service_providers.dart';
import '../../../../domain/entities/task.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/task_reminders_provider.dart';

/// The reminder switch row: schedules a notification before the task is due.
class TaskReminderTile extends ConsumerWidget {
  /// Creates the reminder tile.
  const TaskReminderTile({required this.task, super.key});

  /// The task the reminder is bound to.
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final reminders = ref.watch(taskRemindersProvider(task.id)).value;
    final enabled = reminders != null && reminders.isNotEmpty;
    return AnjizCard(
      child: AnjizSwitchTile(
        title: l10n.labelTaskReminder,
        subtitle: enabled ? l10n.reminderMinutesBefore(15) : l10n.reminderOff,
        value: enabled,
        switchSemanticLabel: l10n.labelTaskReminder,
        onChanged: task.dueAt == null
            ? null
            : (value) => _toggle(context, ref, value),
      ),
    );
  }

  Future<void> _toggle(BuildContext context, WidgetRef ref, bool value) async {
    final l10n = AppLocalizations.of(context);
    final useCase = ref.read(setTaskReminderProvider);
    if (!value) {
      await useCase.clear(task);
      return;
    }
    final granted = await ref
        .read(notificationServiceProvider)
        .requestPermission();
    if (!granted) {
      if (context.mounted) {
        AnjizSnackBar.show(context, message: l10n.errorNotificationMessage);
      }
      return;
    }
    final scheduled = await useCase.schedule(
      task,
      title: task.title,
      body: task.notes.isEmpty ? task.title : task.notes,
    );
    if (!scheduled && context.mounted) {
      AnjizSnackBar.show(context, message: l10n.errorNotificationMessage);
    }
  }
}

/// Edit flows for the task-detail screen.
///
/// Each helper opens the matching picker/sheet and persists the change through
/// the shared task-actions notifier. Kept out of the screen so it stays a thin
/// composition of widgets.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers/task_actions.dart';
import '../../../app/widgets/task_pickers.dart';
import '../../../domain/entities/task.dart';
import '../../../l10n/app_localizations.dart';
import 'sheets/edit_text_sheet.dart';
import 'sheets/repeat_picker.dart';
import 'widgets/task_recurrence.dart';

/// Prompts for a new title and saves it when non-empty.
Future<void> editTaskTitle(
  BuildContext context,
  WidgetRef ref,
  Task task,
) async {
  final l10n = AppLocalizations.of(context);
  final value = await showEditTextSheet(
    context,
    title: l10n.actionNewTask,
    initial: task.title,
    hint: l10n.addTaskHint,
  );
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) return;
  await ref.read(taskActionsProvider).update(task.copyWith(title: trimmed));
}

/// Prompts for the note body and saves it.
Future<void> editTaskNotes(
  BuildContext context,
  WidgetRef ref,
  Task task,
) async {
  final l10n = AppLocalizations.of(context);
  final value = await showEditTextSheet(
    context,
    title: l10n.labelNotes,
    initial: task.notes,
    hint: l10n.labelNotes,
    maxLines: 5,
  );
  if (value == null) return;
  await ref.read(taskActionsProvider).update(task.copyWith(notes: value));
}

/// Picks a new due date, preserving any existing time-of-day.
Future<void> editTaskDue(BuildContext context, WidgetRef ref, Task task) async {
  final now = DateTime.now();
  final picked = await showDatePicker(
    context: context,
    initialDate: task.dueAt ?? now,
    firstDate: now.subtract(const Duration(days: 365)),
    lastDate: now.add(const Duration(days: 3650)),
  );
  if (picked == null) return;
  final base = task.dueAt;
  final due = base == null
      ? picked
      : DateTime(picked.year, picked.month, picked.day, base.hour, base.minute);
  await ref
      .read(taskActionsProvider)
      .update(task.copyWith(dueAt: due, hasTime: base != null && task.hasTime));
}

/// Prompts for a repeat rule and saves it.
Future<void> editTaskRecurrence(
  BuildContext context,
  WidgetRef ref,
  Task task,
) async {
  final choice = await showRepeatPicker(context, task.repeatRule);
  if (choice == null) return;
  await ref
      .read(taskActionsProvider)
      .update(task.copyWith(repeatRule: RepeatRules.normalise(choice)));
}

/// Prompts for a target list and moves the task into it.
Future<void> changeTaskList(
  BuildContext context,
  WidgetRef ref,
  Task task,
) async {
  final listId = await showListPicker(context, ref);
  if (listId == null) return;
  await ref.read(taskActionsProvider).update(task.copyWith(listId: listId));
}

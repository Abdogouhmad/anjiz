import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../core/utils/task_format.dart';
import '../../domain/entities/priority.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_list.dart';
import '../../l10n/app_localizations.dart';

/// Builds the metadata chips shown beneath a task's title: due time, list and
/// priority. Shared by the Today, Upcoming, Lists and Search screens.
List<Widget> buildTaskMetaChips(
  BuildContext context, {
  required Task task,
  TaskList? list,
  bool showTime = true,
  bool showPriority = true,
}) {
  final l10n = AppLocalizations.of(context);
  final chips = <Widget>[];
  final due = task.dueAt;
  if (showTime && due != null && task.hasTime) {
    chips.add(
      AnjizMetaChip(label: TaskFormat.time(context, due), icon: Icons.schedule),
    );
  }
  if (list != null) {
    chips.add(AnjizMetaChip(label: list.name, icon: Icons.folder_outlined));
  }
  if (showPriority && task.priority != Priority.none) {
    chips.add(AnjizPriorityChip(label: priorityLabel(l10n, task.priority)));
  }
  return chips;
}

/// Localises a [Priority] value.
String priorityLabel(AppLocalizations l10n, Priority priority) {
  return switch (priority) {
    Priority.none => l10n.priorityNone,
    Priority.low => l10n.priorityLow,
    Priority.medium => l10n.priorityMedium,
    Priority.high => l10n.priorityHigh,
  };
}

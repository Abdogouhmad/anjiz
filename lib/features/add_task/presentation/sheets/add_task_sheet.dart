import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../widgets/add_task_form.dart';

/// Opens the Add Task modal sheet.
Future<void> showAddTaskSheet(
  BuildContext context, {
  String? listId,
  DateTime? initialDue,
  bool initialHasTime = false,
}) {
  return AnjizBottomSheet.show<void>(
    context,
    child: AddTaskSheet(
      listId: listId,
      initialDue: initialDue,
      initialHasTime: initialHasTime,
    ),
  );
}

/// The Add Task sheet surface.
class AddTaskSheet extends StatelessWidget {
  /// Creates the sheet.
  const AddTaskSheet({
    this.listId,
    this.initialDue,
    this.initialHasTime = false,
    super.key,
  });

  /// The list new tasks are filed under.
  final String? listId;

  /// A pre-selected due date.
  final DateTime? initialDue;

  /// Whether the pre-selected due date carries a time.
  final bool initialHasTime;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AnjizSheetContent(
      title: l10n.actionNewTask,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: AddTaskForm(
          listId: listId,
          initialDue: initialDue,
          initialHasTime: initialHasTime,
        ),
      ),
    );
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/use_case_providers.dart';
import '../../../../l10n/app_localizations.dart';

/// Opens the "Add subtask" modal sheet for [taskId].
Future<void> showAddSubtaskSheet(
  BuildContext context, {
  required String taskId,
  required int sortOrder,
}) => AnjizBottomSheet.show<void>(
  context,
  child: AddSubtaskSheet(taskId: taskId, sortOrder: sortOrder),
);

/// A compact sheet capturing a new checklist item.
class AddSubtaskSheet extends ConsumerStatefulWidget {
  /// Creates the sheet.
  const AddSubtaskSheet({
    required this.taskId,
    required this.sortOrder,
    super.key,
  });

  /// The task the subtask is nested under.
  final String taskId;

  /// Position the subtask is appended at.
  final int sortOrder;

  @override
  ConsumerState<AddSubtaskSheet> createState() => _AddSubtaskSheetState();
}

class _AddSubtaskSheetState extends ConsumerState<AddSubtaskSheet> {
  final TextEditingController _title = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final title = _title.text.trim();
    if (title.isEmpty) {
      AnjizSnackBar.show(context, message: l10n.errorValidationMessage);
      return;
    }
    await ref
        .read(addSubtaskProvider)
        .call(taskId: widget.taskId, title: title, sortOrder: widget.sortOrder);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AnjizSheetContent(
      title: l10n.actionAddSubtask,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnjizTextField(
              controller: _title,
              autofocus: true,
              hintText: l10n.actionAddSubtask,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AnjizSpacing.lg),
            AnjizButton(
              label: l10n.actionAddSubtask,
              icon: Icons.add_rounded,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/use_case_providers.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/service_providers.dart';
import '../../../../domain/entities/priority.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../app/widgets/task_pickers.dart';
import 'due_schedule_selector.dart';
import 'task_metadata_row.dart';

/// The interactive Add Task form: title, notes, scheduling and metadata.
class AddTaskForm extends ConsumerStatefulWidget {
  /// Creates the form.
  const AddTaskForm({
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
  ConsumerState<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends ConsumerState<AddTaskForm> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  late DateTime? _due = widget.initialDue;
  late bool _hasTime = widget.initialHasTime;
  late String _listId = widget.listId ?? AppConstants.defaultListId;
  Priority _priority = Priority.none;
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _submit({required bool addAnother}) async {
    final l10n = AppLocalizations.of(context);
    final title = _title.text.trim();
    if (title.isEmpty) {
      AnjizSnackBar.show(context, message: l10n.errorValidationMessage);
      return;
    }
    setState(() => _saving = true);
    try {
      // Reminders are scheduled from the save flow, so the notification
      // permission has to be in place before the task is stored.
      final scheduleReminder =
          _due == null || await _ensureNotificationPermission(l10n);
      await ref
          .read(addTaskProvider)
          .call(
            title: title,
            listId: _listId,
            notes: _notes.text.trim(),
            dueAt: _due,
            hasTime: _hasTime,
            priority: _priority,
            scheduleReminder: scheduleReminder,
          );
      if (!mounted) return;
      if (addAnother) {
        _title.clear();
        _notes.clear();
        setState(() => _priority = Priority.none);
      } else {
        Navigator.of(context).pop();
      }
    } on Failure catch (failure) {
      if (mounted) {
        AnjizSnackBar.show(context, message: failure.message);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  /// Requests the notification permission once, reporting whether reminders
  /// may be scheduled. A denied request surfaces a snackbar but still lets
  /// the task be saved (without reminders).
  Future<bool> _ensureNotificationPermission(AppLocalizations l10n) async {
    final notifications = ref.read(notificationServiceProvider);
    final granted =
        await notifications.areNotificationsEnabled() ||
        await notifications.requestPermission();
    if (!granted && mounted) {
      AnjizSnackBar.show(context, message: l10n.errorNotificationMessage);
    }
    return granted;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _due ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) setState(() => _due = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_due ?? DateTime.now()),
    );
    if (picked != null) {
      final base = _due ?? DateTime.now();
      setState(() {
        _due = DateTime(
          base.year,
          base.month,
          base.day,
          picked.hour,
          picked.minute,
        );
        _hasTime = true;
      });
    }
  }

  Future<void> _pickList() async {
    final id = await showListPicker(context, ref);
    if (id != null) setState(() => _listId = id);
  }

  Future<void> _pickPriority() async {
    final value = await showPriorityPicker(context, ref, _priority);
    if (value != null) setState(() => _priority = value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnjizTextField(
          controller: _title,
          autofocus: true,
          hintText: l10n.addTaskHint,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: AnjizSpacing.md),
        AnjizTextField(
          controller: _notes,
          labelText: l10n.labelNotes,
          maxLines: 3,
          minLines: 1,
        ),
        const SizedBox(height: AnjizSpacing.lg),
        DueScheduleSelector(
          due: _due,
          hasTime: _hasTime,
          onPreset: (value) => setState(() {
            _due = value;
            _hasTime = false;
          }),
          onPickDate: _pickDate,
          onPickTime: _pickTime,
        ),
        const SizedBox(height: AnjizSpacing.lg),
        TaskMetadataRow(
          listId: _listId,
          priority: _priority,
          due: _due,
          hasTime: _hasTime,
          onPickList: _pickList,
          onPickPriority: _pickPriority,
        ),
        const SizedBox(height: AnjizSpacing.lg),
        Row(
          children: [
            IconButton.filledTonal(
              onPressed: _pickTime,
              tooltip: l10n.actionAddVoiceNote,
              icon: const Icon(Icons.mic_none_rounded),
            ),
            const Spacer(),
            AnjizButton(
              label: l10n.actionAddAnother,
              variant: AnjizButtonVariant.tonal,
              onPressed: _saving ? null : () => _submit(addAnother: true),
            ),
            const SizedBox(width: AnjizSpacing.sm),
            AnjizButton(
              label: l10n.actionAddTask,
              icon: Icons.check_rounded,
              loading: _saving,
              onPressed: () => _submit(addAnother: false),
            ),
          ],
        ),
      ],
    );
  }
}

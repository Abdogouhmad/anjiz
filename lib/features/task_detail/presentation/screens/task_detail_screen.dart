import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/providers/task_actions.dart';
import '../../../../app/providers/task_queries.dart';
import '../../../../app/widgets/profile_avatar.dart';
import '../../../../core/utils/task_format.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/task_list.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../app/widgets/task_pickers.dart';
import '../providers/task_by_id_provider.dart';
import '../sheets/edit_text_sheet.dart';
import '../sheets/repeat_picker.dart';
import '../widgets/notes_card.dart';
import '../widgets/subtask_list_card.dart';
import '../widgets/task_detail_info_card.dart';
import '../widgets/task_reminder_tile.dart';
import '../widgets/task_recurrence.dart';

/// The task-detail screen: editable title, notes, subtasks, scheduling info and
/// the floating action toolbar.
class TaskDetailScreen extends ConsumerWidget {
  /// Creates a task-detail screen for [taskId].
  const TaskDetailScreen({required this.taskId, super.key});

  /// The task being viewed.
  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final task = ref.watch(taskByIdProvider(taskId));
    final margin = AnjizBreakpoints.margin(AnjizBreakpoints.of(context));
    final data = task.value;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AnjizLargeAppBar(
            title: l10n.taskDetailTitle,
            leading: BackButton(onPressed: () => context.pop()),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: AnjizSpacing.md),
                child: ProfileAvatar(
                  onTap: () => context.go(AppRoutes.settings),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsetsDirectional.fromSTEB(
              margin,
              AnjizSpacing.sm,
              margin,
              AnjizSpacing.xxl,
            ),
            sliver: SliverList.list(
              children: _content(context, ref, l10n, task),
            ),
          ),
        ],
      ),
      bottomNavigationBar: data == null
          ? null
          : _toolbar(context, ref, l10n, data),
    );
  }

  List<Widget> _content(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    AsyncValue<Task?> task,
  ) {
    return task.when(
      data: (value) {
        if (value == null) {
          return [
            AnjizEmptyState(
              title: l10n.emptyListTitle,
              message: l10n.emptyListMessage,
              icon: Icons.task_alt_rounded,
            ),
          ];
        }
        return _cards(context, ref, l10n, value);
      },
      loading: () => const [
        Padding(padding: EdgeInsets.all(AnjizSpacing.xl), child: AnjizLoader()),
      ],
      error: (error, stackTrace) => [
        AnjizErrorView(
          title: l10n.errorTitle,
          message: l10n.errorDatabaseMessage,
          onRetry: () => ref.invalidate(taskByIdProvider(taskId)),
          retryLabel: l10n.actionRetry,
        ),
      ],
    );
  }

  List<Widget> _cards(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    Task task,
  ) {
    final lists = ref.watch(taskListsProvider).value ?? const <TaskList>[];
    String? listName;
    for (final list in lists) {
      if (list.id == task.listId) listName = list.name;
    }
    return [
      _TitleCard(task: task, onEdit: () => _editTitle(context, ref, task)),
      const SizedBox(height: AnjizSpacing.md),
      NotesCard(
        notes: task.notes,
        onEdit: () => _editNotes(context, ref, task),
      ),
      const SizedBox(height: AnjizSpacing.md),
      SubtaskListCard(taskId: task.id),
      const SizedBox(height: AnjizSpacing.md),
      TaskDetailInfoCard(
        task: task,
        listName: listName,
        onEditDue: () => _editDue(context, ref, task),
        onEditRecurrence: () => _editRecurrence(context, ref, task),
        onChangeList: () => _changeList(context, ref, task),
      ),
      const SizedBox(height: AnjizSpacing.md),
      TaskReminderTile(task: task),
    ];
  }

  Future<void> _editTitle(
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

  Future<void> _editNotes(
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

  Future<void> _editDue(BuildContext context, WidgetRef ref, Task task) async {
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
        : DateTime(
            picked.year,
            picked.month,
            picked.day,
            base.hour,
            base.minute,
          );
    await ref
        .read(taskActionsProvider)
        .update(
          task.copyWith(dueAt: due, hasTime: base != null && task.hasTime),
        );
  }

  Future<void> _editRecurrence(
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

  Future<void> _changeList(
    BuildContext context,
    WidgetRef ref,
    Task task,
  ) async {
    final listId = await showListPicker(context, ref);
    if (listId == null) return;
    await ref.read(taskActionsProvider).update(task.copyWith(listId: listId));
  }

  Widget _toolbar(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    Task task,
  ) {
    final actions = ref.read(taskActionsProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AnjizSpacing.md),
        child: AnjizFloatingToolbar(
          primaryLabel: l10n.actionMarkComplete,
          primaryIcon: Icons.check_circle_outline,
          onPrimaryPressed: () async {
            await actions.toggleDone(task, isDone: true);
            if (context.mounted) context.pop();
          },
          actions: [
            (
              icon: task.isStarred
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
              tooltip: task.isStarred
                  ? l10n.actionUnstarTask
                  : l10n.actionStarTask,
              onPressed: () =>
                  actions.toggleStar(task, isStarred: !task.isStarred),
            ),
            (
              icon: Icons.snooze_rounded,
              tooltip: l10n.actionSnooze,
              onPressed: () => _snooze(ref, task),
            ),
            (
              icon: Icons.delete_outline_rounded,
              tooltip: l10n.actionDelete,
              onPressed: () async {
                await actions.delete(task);
                if (context.mounted) context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _snooze(WidgetRef ref, Task task) {
    final due = task.dueAt ?? DateTime.now();
    ref
        .read(taskActionsProvider)
        .update(task.copyWith(dueAt: due.add(const Duration(days: 1))));
  }
}

class _TitleCard extends StatelessWidget {
  const _TitleCard({required this.task, required this.onEdit});

  final Task task;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AnjizCard(
      onTap: onEdit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: textTheme.headlineSmall?.copyWith(
              color: task.isDone ? scheme.onSurfaceVariant : scheme.onSurface,
              decoration: task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              decorationColor: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AnjizSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.edit_outlined,
                size: 14,
                color: scheme.onSurfaceVariant,
              ),
              const SizedBox(width: AnjizSpacing.xs),
              Flexible(
                child: Text(
                  l10n.labelTapToEdit,
                  style: textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: AnjizSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: scheme.onSurfaceVariant,
                  shape: BoxShape.circle,
                ),
              ),
              Flexible(
                child: Text(
                  l10n.labelCreatedAt(TaskFormat.time(context, task.createdAt)),
                  style: textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

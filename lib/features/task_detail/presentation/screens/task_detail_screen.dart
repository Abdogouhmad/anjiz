import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/providers/task_queries.dart';
import '../../../../app/widgets/profile_avatar.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/task_list.dart';
import '../../../../features/pomodoro/pomodoro.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/task_by_id_provider.dart';
import '../widgets/notes_card.dart';
import '../widgets/subtask_list_card.dart';
import '../widgets/task_detail_info_card.dart';
import '../widgets/task_detail_toolbar.dart';
import '../widgets/task_reminder_tile.dart';
import '../widgets/task_title_card.dart';
import '../task_detail_editors.dart';

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
      bottomNavigationBar: data == null ? null : TaskDetailToolbar(task: data),
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
        return _cards(context, ref, value);
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

  List<Widget> _cards(BuildContext context, WidgetRef ref, Task task) {
    final lists = ref.watch(taskListsProvider).value ?? const <TaskList>[];
    String? listName;
    for (final list in lists) {
      if (list.id == task.listId) listName = list.name;
    }
    return [
      TaskTitleCard(
        task: task,
        onEdit: () => editTaskTitle(context, ref, task),
      ),
      const SizedBox(height: AnjizSpacing.md),
      NotesCard(
        notes: task.notes,
        onEdit: () => editTaskNotes(context, ref, task),
      ),
      const SizedBox(height: AnjizSpacing.md),
      SubtaskListCard(taskId: task.id),
      const SizedBox(height: AnjizSpacing.md),
      FocusTaskCard(task: task),
      const SizedBox(height: AnjizSpacing.md),
      TaskDetailInfoCard(
        task: task,
        listName: listName,
        onEditDue: () => editTaskDue(context, ref, task),
        onEditRecurrence: () => editTaskRecurrence(context, ref, task),
        onChangeList: () => changeTaskList(context, ref, task),
      ),
      const SizedBox(height: AnjizSpacing.md),
      TaskReminderTile(task: task),
    ];
  }
}

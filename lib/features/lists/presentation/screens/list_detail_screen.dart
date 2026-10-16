import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/providers/task_queries.dart';
import '../../../../app/widgets/task_row.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/task_list.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../add_task/add_task.dart';
import '../sheets/create_list_sheet.dart';

/// A single list with its open and completed tasks.
class ListDetailScreen extends ConsumerWidget {
  /// Creates a list-detail screen for [listId].
  const ListDetailScreen({required this.listId, super.key});

  /// The list being viewed.
  final String listId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final lists = ref.watch(taskListsProvider).value ?? const <TaskList>[];
    final tasks = ref.watch(listTasksProvider(listId));
    final margin = AnjizBreakpoints.margin(AnjizBreakpoints.of(context));
    final list = _find(lists);
    final data = tasks.value ?? const <Task>[];
    final open = data.where((task) => !task.isDone).toList();
    final completed = data.where((task) => task.isDone).toList();
    return Scaffold(
      floatingActionButton: AnjizFabMenu(
        label: l10n.actionNewTask,
        onPressed: () => showAddTaskSheet(context, listId: listId),
        expandTooltip: l10n.actionExpandMenu,
        collapseTooltip: l10n.actionCollapseMenu,
        actions: [
          (
            label: l10n.actionNewList,
            icon: Icons.playlist_add_rounded,
            onPressed: () => showCreateListSheet(context),
          ),
          (
            label: l10n.actionAddVoiceNote,
            icon: Icons.mic_none_rounded,
            onPressed: () => showAddTaskSheet(context, listId: listId),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          AnjizLargeAppBar(
            title: list?.name ?? l10n.navLists,
            subtitle: l10n.tasksRemaining(open.length),
            leading: BackButton(onPressed: () => context.pop()),
          ),
          SliverPadding(
            padding: EdgeInsetsDirectional.fromSTEB(
              margin,
              AnjizSpacing.sm,
              margin,
              AnjizSpacing.xxl,
            ),
            sliver: SliverList.list(
              children: [
                if (completed.isNotEmpty || open.isNotEmpty)
                  _ProgressHeader(
                    total: data.length,
                    completed: completed.length,
                  ),
                const SizedBox(height: AnjizSpacing.md),
                ...tasks.when(
                  data: (_) => _groups(context, l10n, open, completed),
                  loading: () => const [
                    Padding(
                      padding: EdgeInsets.all(AnjizSpacing.xl),
                      child: AnjizLoader(),
                    ),
                  ],
                  error: (error, stackTrace) => [
                    AnjizErrorView(
                      title: l10n.errorTitle,
                      message: l10n.errorDatabaseMessage,
                      onRetry: () => ref.invalidate(listTasksProvider(listId)),
                      retryLabel: l10n.actionRetry,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TaskList? _find(List<TaskList> lists) {
    for (final list in lists) {
      if (list.id == listId) return list;
    }
    return null;
  }

  List<Widget> _groups(
    BuildContext context,
    AppLocalizations l10n,
    List<Task> open,
    List<Task> completed,
  ) {
    if (open.isEmpty && completed.isEmpty) {
      return [
        AnjizEmptyState(
          title: l10n.emptyListTitle,
          message: l10n.emptyListMessage,
          icon: Icons.checklist_rounded,
          actions: [
            AnjizButton(
              label: l10n.actionAddTask,
              icon: Icons.add_rounded,
              onPressed: () => showAddTaskSheet(context, listId: listId),
            ),
          ],
        ),
      ];
    }
    return [
      if (open.isNotEmpty) ...[
        AnjizSectionHeader(title: l10n.activeTasksCount(open.length)),
        for (final task in open)
          Padding(
            padding: const EdgeInsets.only(bottom: AnjizSpacing.sm),
            child: TaskRow(
              task: task,
              onTap: () => context.push(AppRoutes.task(task.id)),
            ),
          ),
      ],
      if (completed.isNotEmpty) ...[
        const SizedBox(height: AnjizSpacing.sm),
        AnjizSectionHeader(title: l10n.statCompleted),
        for (final task in completed)
          Padding(
            padding: const EdgeInsets.only(bottom: AnjizSpacing.sm),
            child: TaskRow(
              task: task,
              onTap: () => context.push(AppRoutes.task(task.id)),
            ),
          ),
      ],
    ];
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.total, required this.completed});

  final int total;
  final int completed;

  @override
  Widget build(BuildContext context) {
    return AnjizCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnjizListTile(
            leading: const AnjizIconBadge(
              icon: Icons.folder_outlined,
              tone: AnjizTone.primary,
              size: 40,
              iconSize: 20,
            ),
            title: Text(AppLocalizations.of(context).labelProgress),
            trailing: AnjizCountBadge(label: '$completed/$total'),
          ),
          const SizedBox(height: AnjizSpacing.sm),
          AnjizWavyProgress(value: total == 0 ? 0 : completed / total),
        ],
      ),
    );
  }
}

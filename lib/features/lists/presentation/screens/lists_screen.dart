import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/providers/task_queries.dart';
import '../../../../app/widgets/profile_avatar.dart';
import '../../../../core/extensions/datetime_extensions.dart';
import '../../../../domain/entities/task.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/task_list_summaries_provider.dart';
import '../providers/task_list_summary.dart';
import '../sheets/create_list_sheet.dart';
import '../widgets/daily_milestone_card.dart';
import '../widgets/lists_grid.dart';
import '../widgets/lists_stats_strip.dart';

/// The Lists overview: aggregate stats, the list grid and daily momentum.
class ListsScreen extends ConsumerWidget {
  /// Creates the Lists screen.
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final summaries = ref.watch(taskListSummariesProvider);
    final active = ref.watch(activeTaskCountProvider);
    final tasks = ref.watch(allTasksProvider).value ?? const <Task>[];
    final margin = AnjizBreakpoints.margin(AnjizBreakpoints.of(context));
    final today = _todayProgress(tasks, DateTime.now());
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            AnjizLargeAppBar(
              title: l10n.navLists,
              subtitle: l10n.listsSubtitle,
              actions: [
                IconButton(
                  onPressed: () => context.push(AppRoutes.search),
                  tooltip: l10n.searchTitle,
                  icon: const Icon(Icons.search_rounded),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: AnjizSpacing.md,
                  ),
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
                // Clear the floating glass navigation bar.
                AnjizSpacing.xxl + AnjizFloatingNavBar.contentBottomInset,
              ),
              sliver: SliverList.list(
                children: [
                  ListsStatsStrip(
                    projects: summaries.length,
                    activeTasks: active,
                    weeklyVelocity: _velocity(summaries),
                  ),
                  const SizedBox(height: AnjizSpacing.lg),
                  ListsGrid(
                    summaries: summaries,
                    onOpenList: (summary) =>
                        context.push(AppRoutes.list(summary.list.id)),
                    onCreateList: () => showCreateListSheet(context),
                  ),
                  const SizedBox(height: AnjizSpacing.lg),
                  DailyMilestoneCard(
                    completedToday: today.completed,
                    progress: today.progress,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _velocity(List<TaskListSummary> summaries) {
    var total = 0;
    var completed = 0;
    for (final summary in summaries) {
      total += summary.total;
      completed += summary.completed;
    }
    return total == 0 ? 0 : completed / total;
  }

  ({int completed, double progress}) _todayProgress(
    List<Task> tasks,
    DateTime now,
  ) {
    var scheduled = 0;
    var completed = 0;
    for (final task in tasks) {
      final due = task.dueAt;
      if (due == null || !due.isSameDay(now)) continue;
      scheduled++;
      if (task.isDone) completed++;
    }
    return (
      completed: completed,
      progress: scheduled == 0 ? 0 : completed / scheduled,
    );
  }
}

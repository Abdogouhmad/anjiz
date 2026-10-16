import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/providers/task_actions.dart';
import '../../../../app/widgets/profile_avatar.dart';
import '../../../../core/utils/task_format.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/today_agenda.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../add_task/add_task.dart';
import '../providers/today_agenda_provider.dart';
import '../widgets/today_agenda_sections.dart';
import '../widgets/today_greeting_banner.dart';

/// The Today screen: greeting banner followed by the grouped daily agenda.
class TodayScreen extends ConsumerWidget {
  /// Creates the Today screen.
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final agenda = ref.watch(todayAgendaProvider);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            AnjizLargeAppBar(
              title: l10n.navToday,
              subtitle: TaskFormat.fullDay(now),
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
                AnjizBreakpoints.margin(AnjizBreakpoints.of(context)),
                AnjizSpacing.sm,
                AnjizBreakpoints.margin(AnjizBreakpoints.of(context)),
                AnjizSpacing.xxl,
              ),
              sliver: SliverList.list(
                children: [
                  TodayGreetingBanner(remaining: agenda.value?.remaining ?? 0),
                  const SizedBox(height: AnjizSpacing.lg),
                  ..._body(context, ref, l10n, agenda),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _body(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    AsyncValue<TodayAgenda> agenda,
  ) {
    return agenda.when(
      data: (data) {
        if (data.isClear && data.completed.isEmpty) {
          return [_emptyToday(context, ref, l10n, data)];
        }
        return [
          TodayAgendaSections(
            agenda: data,
            onOpenTask: (task) => context.push(AppRoutes.task(task.id)),
            onRescheduleAll: () => _rescheduleAll(ref, data.overdue),
          ),
        ];
      },
      loading: () => const [
        Padding(padding: EdgeInsets.all(AnjizSpacing.xl), child: AnjizLoader()),
      ],
      error: (error, stackTrace) => [
        AnjizErrorView(
          title: l10n.errorTitle,
          message: l10n.errorDatabaseMessage,
          onRetry: () => ref.invalidate(todayAgendaProvider),
          retryLabel: l10n.actionRetry,
        ),
      ],
    );
  }

  Widget _emptyToday(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    TodayAgenda data,
  ) {
    final now = DateTime.now();
    return AnjizEmptyState(
      title: l10n.emptyTodayTitle,
      message: l10n.emptyTodayMessage(data.completed.length),
      icon: Icons.eco_rounded,
      actions: [
        AnjizButton(
          label: l10n.actionPlanTomorrow,
          icon: Icons.event_available_rounded,
          onPressed: () => showAddTaskSheet(
            context,
            initialDue: DateTime(now.year, now.month, now.day + 1),
          ),
        ),
      ],
    );
  }

  void _rescheduleAll(WidgetRef ref, List<Task> overdue) {
    final actions = ref.read(taskActionsProvider);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    for (final task in overdue) {
      actions.update(task.copyWith(dueAt: today, hasTime: false));
    }
  }
}

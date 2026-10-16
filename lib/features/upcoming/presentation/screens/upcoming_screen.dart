import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/widgets/profile_avatar.dart';
import '../../../../core/extensions/datetime_extensions.dart';
import '../../../../domain/entities/upcoming_agenda.dart';
import '../../../../domain/entities/upcoming_day.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../add_task/add_task.dart';
import '../../../today/presentation/providers/today_agenda_provider.dart';
import '../providers/upcoming_agenda_provider.dart';
import '../widgets/momentum_card.dart';
import '../widgets/upcoming_date_strip.dart';
import '../widgets/upcoming_day_section.dart';

/// The Upcoming screen: date strip, weekly momentum and the seven-day agenda.
class UpcomingScreen extends ConsumerStatefulWidget {
  /// Creates the Upcoming screen.
  const UpcomingScreen({super.key});

  @override
  ConsumerState<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends ConsumerState<UpcomingScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final agenda = ref.watch(upcomingAgendaProvider);
    final todayCount = ref.watch(todayAgendaProvider).value?.remaining ?? 0;
    final margin = AnjizBreakpoints.margin(AnjizBreakpoints.of(context));
    final data = agenda.value;
    final days = data?.days ?? const <UpcomingDay>[];
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            AnjizLargeAppBar(
              title: l10n.navUpcoming,
              subtitle: l10n.upcomingSubtitle,
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
                AnjizSpacing.xxl,
              ),
              sliver: SliverList.list(
                children: [
                  _MonthHeader(month: DateFormat('MMMM yyyy').format(now)),
                  const SizedBox(height: AnjizSpacing.md),
                  UpcomingDateStrip(
                    dates: [now.startOfDay, for (final day in days) day.date],
                    counts: [
                      todayCount,
                      for (final day in days) day.tasks.length,
                    ],
                    selectedIndex: _selected,
                    onSelected: (index) => setState(() => _selected = index),
                  ),
                  const SizedBox(height: AnjizSpacing.lg),
                  ..._body(context, l10n, now, agenda, days),
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
    AppLocalizations l10n,
    DateTime now,
    AsyncValue<UpcomingAgenda> agenda,
    List<UpcomingDay> days,
  ) {
    return agenda.when(
      data: (data) => [
        MomentumCard(agenda: data),
        if (_selected == 0)
          for (final day in days)
            UpcomingDaySection(
              day: day,
              now: now,
              onOpenTask: (task) => context.push(AppRoutes.task(task.id)),
              onAddTask: () => showAddTaskSheet(context, initialDue: day.date),
            )
        else
          UpcomingDaySection(
            day: days[_selected - 1],
            now: now,
            onOpenTask: (task) => context.push(AppRoutes.task(task.id)),
            onAddTask: () =>
                showAddTaskSheet(context, initialDue: days[_selected - 1].date),
          ),
      ],
      loading: () => const [
        Padding(padding: EdgeInsets.all(AnjizSpacing.xl), child: AnjizLoader()),
      ],
      error: (error, stackTrace) => [
        AnjizErrorView(
          title: l10n.errorTitle,
          message: l10n.errorDatabaseMessage,
          onRetry: () => ref.invalidate(upcomingAgendaProvider),
          retryLabel: l10n.actionRetry,
        ),
      ],
    );
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({required this.month});

  final String month;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Text(month, style: Theme.of(context).textTheme.titleMedium),
        ),
        AnjizMetaChip(
          label: l10n.actionFullCalendar,
          icon: Icons.calendar_month_outlined,
          tone: AnjizTone.primary,
        ),
      ],
    );
  }
}

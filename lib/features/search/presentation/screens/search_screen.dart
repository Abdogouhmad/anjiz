import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/widgets/task_row.dart';
import '../../../../domain/entities/task.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/search_providers.dart';

/// Full-screen search across every task's title and notes.
class SearchScreen extends ConsumerStatefulWidget {
  /// Creates the search screen.
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = ref.watch(searchQueryProvider);
    final results = ref.watch(searchResultsProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AnjizSpacing.sm,
                AnjizSpacing.sm,
                AnjizSpacing.md,
                AnjizSpacing.sm,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    tooltip: MaterialLocalizations.of(context)
                        .backButtonTooltip,
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  Expanded(
                    child: AnjizSearchBar(
                      hintText: l10n.searchHint,
                      controller: _controller,
                      autofocus: true,
                      onChanged: (value) =>
                          ref.read(searchQueryProvider.notifier).set(value),
                      trailing: query.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _controller.clear();
                                ref.read(searchQueryProvider.notifier).clear();
                              },
                              tooltip: l10n.actionClear,
                              icon: const Icon(Icons.close_rounded),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _results(context, l10n, query, results)),
          ],
        ),
      ),
    );
  }

  Widget _results(
    BuildContext context,
    AppLocalizations l10n,
    String query,
    AsyncValue<List<Task>> results,
  ) {
    if (query.trim().isEmpty) {
      return AnjizEmptyState(
        title: l10n.searchPromptTitle,
        message: l10n.searchPromptMessage,
        icon: Icons.search_rounded,
      );
    }
    return results.when(
      data: (tasks) {
        if (tasks.isEmpty) {
          return AnjizEmptyState(
            title: l10n.searchEmptyTitle,
            message: l10n.searchEmptyMessage,
            icon: Icons.search_off_rounded,
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            AnjizSpacing.md,
            0,
            AnjizSpacing.md,
            AnjizSpacing.xxl,
          ),
          itemCount: tasks.length + 1,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AnjizSpacing.sm),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AnjizSpacing.sm),
                child: AnjizSectionHeader(
                  title: l10n.searchTitle,
                  count: l10n.tasksCount(tasks.length),
                ),
              );
            }
            final task = tasks[index - 1];
            return TaskRow(
              task: task,
              onTap: () => context.push(AppRoutes.task(task.id)),
            );
          },
        );
      },
      loading: () => const Center(child: AnjizLoader()),
      error: (error, stackTrace) => AnjizErrorView(
        title: l10n.errorTitle,
        message: l10n.errorDatabaseMessage,
        onRetry: () => ref.invalidate(searchResultsProvider),
        retryLabel: l10n.actionRetry,
      ),
    );
  }
}

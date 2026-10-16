import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/lists/lists.dart';
import '../features/onboarding/onboarding.dart';
import '../features/search/search.dart';
import '../features/settings/settings.dart';
import '../features/task_detail/task_detail.dart';
import '../features/today/today.dart';
import '../features/upcoming/upcoming.dart';
import '../l10n/app_localizations.dart';
import 'app_routes.dart';
import 'widgets/anjiz_shell_scaffold.dart';

part 'router.g.dart';

/// Provides the application [GoRouter].
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.today,
    redirect: (context, state) {
      final done = ref.read(settingsControllerProvider).onboardingComplete;
      final atOnboarding = state.matchedLocation == AppRoutes.onboarding;
      if (!done && !atOnboarding) return AppRoutes.onboarding;
      if (done && atOnboarding) return AppRoutes.today;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.widgetConfig,
        builder: (context, state) => const WidgetConfigScreen(),
      ),
      GoRoute(
        path: AppRoutes.taskPattern,
        builder: (context, state) =>
            TaskDetailScreen(taskId: state.pathParameters['taskId']!),
      ),
      GoRoute(
        path: AppRoutes.listPattern,
        builder: (context, state) =>
            ListDetailScreen(listId: state.pathParameters['listId']!),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AnjizShellScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.today,
                builder: (context, state) => const TodayScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.upcoming,
                builder: (context, state) => const UpcomingScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.lists,
                builder: (context, state) => const ListsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        _RouteErrorPage(message: state.error?.message),
  );
}

class _RouteErrorPage extends StatelessWidget {
  const _RouteErrorPage({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: AnjizErrorView(
        title: l10n.errorTitle,
        message: message ?? l10n.errorMessage,
        onRetry: () => context.go(AppRoutes.today),
        retryLabel: l10n.actionRetry,
      ),
    );
  }
}

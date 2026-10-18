import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/services/widget_launch.dart';
import '../../features/add_task/add_task.dart';
import '../../features/lists/lists.dart';
import '../../l10n/app_localizations.dart';
import 'profile_avatar.dart';

/// The adaptive app shell: navigation bar/rail plus the global expanding FAB.
class AnjizShellScaffold extends ConsumerWidget {
  /// Creates the shell around [navigationShell].
  const AnjizShellScaffold({required this.navigationShell, super.key});

  /// The go_router branch state rendered as the body.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    ref.listen(widgetLaunchesProvider, (previous, next) {
      if (next.value?.host == AppConstants.widgetQuickAddHost) {
        showAddTaskSheet(context);
      }
    });
    return AnjizAdaptiveScaffold(
      body: navigationShell,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
      railLeading: const ProfileAvatar(),
      destinations: [
        (
          label: l10n.navToday,
          icon: Icons.today_outlined,
          selectedIcon: Icons.today_rounded,
        ),
        (
          label: l10n.navUpcoming,
          icon: Icons.calendar_month_outlined,
          selectedIcon: Icons.calendar_month_rounded,
        ),
        (
          label: l10n.navLists,
          icon: Icons.checklist_rtl_outlined,
          selectedIcon: Icons.checklist_rtl_rounded,
        ),
        (
          label: l10n.navSettings,
          icon: Icons.settings_outlined,
          selectedIcon: Icons.settings_rounded,
        ),
      ],
      floatingActionButton: AnjizFabMenu(
        label: l10n.actionNewTask,
        onPressed: () => showAddTaskSheet(context),
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
            onPressed: () => showAddTaskSheet(context),
          ),
        ],
      ),
    );
  }
}

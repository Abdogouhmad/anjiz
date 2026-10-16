import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/providers/task_queries.dart';
import '../../../../app/widgets/task_pickers.dart';
import '../../../../domain/entities/task_list.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/widget_settings_controller.dart';

/// Configures which data the Android home-screen widgets surface.
class WidgetConfigScreen extends ConsumerWidget {
  /// Creates the widget configuration screen.
  const WidgetConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final margin = AnjizBreakpoints.margin(AnjizBreakpoints.of(context));
    final settings = ref.watch(widgetSettingsControllerProvider);
    final controller = ref.read(widgetSettingsControllerProvider.notifier);
    final lists = ref.watch(taskListsProvider).value ?? const <TaskList>[];
    final selectedName = _listName(lists, settings.listId) ?? l10n.navLists;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AnjizLargeAppBar(
            title: l10n.widgetConfigTitle,
            subtitle: l10n.widgetConfigSubtitle,
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
                const _WidgetCatalogue(),
                const SizedBox(height: AnjizSpacing.md),
                AnjizSettingsCard(
                  icon: Icons.tune_rounded,
                  title: l10n.widgetConfigTitle,
                  children: [
                    AnjizSettingsNavTile(
                      title: l10n.widgetConfigListLabel,
                      subtitle: selectedName,
                      leading: const AnjizIconBadge(
                        icon: Icons.folder_outlined,
                        tone: AnjizTone.primary,
                        size: 36,
                        iconSize: 18,
                      ),
                      onTap: () async {
                        final id = await showListPicker(context, ref);
                        if (id != null) await controller.setListId(id);
                      },
                    ),
                    const SizedBox(height: AnjizSpacing.md),
                    AnjizSwitchTile(
                      title: l10n.widgetConfigShowCompleted,
                      value: settings.showCompleted,
                      switchSemanticLabel: l10n.widgetConfigShowCompleted,
                      onChanged: (value) =>
                          controller.setShowCompleted(enabled: value),
                    ),
                    const SizedBox(height: AnjizSpacing.md),
                    AnjizSliderTile(
                      title: l10n.widgetConfigOpacity,
                      value: settings.opacity,
                      min: 0.4,
                      max: 1,
                      divisions: 6,
                      valueLabel: l10n.labelPercent(
                        (settings.opacity * 100).round(),
                      ),
                      leadingIcon: Icons.opacity_rounded,
                      onChanged: (value) => controller.setOpacity(value),
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

  String? _listName(List<TaskList> lists, String? id) {
    for (final list in lists) {
      if (list.id == id) return list.name;
    }
    return null;
  }
}

class _WidgetCatalogue extends StatelessWidget {
  const _WidgetCatalogue();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entries = <({IconData icon, String title, String subtitle})>[
      (
        icon: Icons.checklist_rtl_rounded,
        title: l10n.widgetOverviewTitle,
        subtitle: l10n.widgetOverviewSubtitle,
      ),
      (
        icon: Icons.view_agenda_outlined,
        title: l10n.widgetCompactTitle,
        subtitle: l10n.widgetCompactSubtitle,
      ),
      (
        icon: Icons.donut_large_rounded,
        title: l10n.widgetProgressTitle,
        subtitle: l10n.widgetProgressSubtitle,
      ),
      (
        icon: Icons.bolt_rounded,
        title: l10n.widgetQuickAddTitle,
        subtitle: l10n.widgetQuickAddSubtitle,
      ),
    ];
    return AnjizCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < entries.length; i++) ...[
            if (i > 0) const SizedBox(height: AnjizSpacing.md12),
            AnjizListTile(
              leading: AnjizIconBadge(
                icon: entries[i].icon,
                tone: AnjizTone.secondary,
                size: 36,
                iconSize: 18,
              ),
              title: Text(entries[i].title),
              subtitle: Text(entries[i].subtitle),
              trailing: AnjizTagPill(label: l10n.previewLabel),
            ),
          ],
        ],
      ),
    );
  }
}

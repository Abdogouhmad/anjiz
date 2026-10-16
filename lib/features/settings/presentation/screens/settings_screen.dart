import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/widgets/profile_avatar.dart';
import '../../../../core/services/app_info.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/settings_controller.dart';
import '../providers/update_controller.dart';
import '../settings_summaries.dart';
import '../widgets/profile_card.dart';

/// The Settings hub: a profile header, then one section per area of the app.
///
/// Every row's subtitle names its current value, so the hub answers "is my app
/// still set up the way I left it?" without opening anything.
class SettingsScreen extends ConsumerWidget {
  /// Creates the settings hub.
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final update = ref.watch(updateControllerProvider);
    final margin = AnjizBreakpoints.margin(AnjizBreakpoints.of(context));
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            AnjizLargeAppBar(
              title: l10n.settingsTitle,
              subtitle: l10n.settingsSubtitle,
              actions: [
                IconButton(
                  onPressed: () => context.push(AppRoutes.search),
                  tooltip: l10n.searchTitle,
                  icon: const Icon(Icons.search_rounded),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.only(end: AnjizSpacing.md),
                  child: ProfileAvatar(),
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
                  ProfileCard(
                    onManagePlan: () =>
                        AnjizSnackBar.show(context, message: l10n.comingSoon),
                  ),
                  const SizedBox(height: AnjizSpacing.md),
                  AnjizSectionHeader(title: l10n.settingsPreferences),
                  AnjizSettingsNavGroup(
                    entries: [
                      AnjizSettingsNavEntry(
                        icon: Icons.tune_rounded,
                        title: l10n.settingsGeneralTitle,
                        subtitle: themeSummary(l10n, settings),
                        onTap: () => context.go(AppRoutes.settingsGeneral),
                      ),
                      AnjizSettingsNavEntry(
                        icon: Icons.notifications_none_rounded,
                        tone: AnjizTone.tertiary,
                        title: l10n.notificationsTitle,
                        subtitle: settings.dailyBriefing
                            ? l10n.settingsNotificationsOn
                            : l10n.settingsNotificationsOff,
                        onTap: () =>
                            context.go(AppRoutes.settingsNotifications),
                      ),
                    ],
                  ),
                  const SizedBox(height: AnjizSpacing.md),
                  AnjizSectionHeader(title: l10n.settingsData),
                  AnjizSettingsNavGroup(
                    entries: [
                      AnjizSettingsNavEntry(
                        icon: Icons.cloud_sync_outlined,
                        tone: AnjizTone.secondary,
                        title: l10n.dataTitle,
                        subtitle: l10n.settingsDataSubtitle,
                        onTap: () => context.go(AppRoutes.settingsData),
                      ),
                    ],
                  ),
                  const SizedBox(height: AnjizSpacing.md),
                  AnjizSectionHeader(title: l10n.settingsOther),
                  AnjizSettingsNavGroup(
                    entries: [
                      AnjizSettingsNavEntry(
                        icon: update.hasUpdate
                            ? Icons.system_update_alt_rounded
                            : Icons.system_update_rounded,
                        tone: update.hasUpdate
                            ? AnjizTone.primary
                            : AnjizTone.neutral,
                        title: l10n.updateTitle,
                        subtitle: updateSummary(l10n, update),
                        onTap: () => context.go(AppRoutes.settingsUpdate),
                      ),
                      AnjizSettingsNavEntry(
                        icon: Icons.info_outline_rounded,
                        tone: AnjizTone.neutral,
                        title: l10n.settingsAboutTitle,
                        subtitle: l10n.settingsAboutSummary(AppInfo.version),
                        onTap: () => context.go(AppRoutes.settingsAbout),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

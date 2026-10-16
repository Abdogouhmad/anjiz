import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/widgets/profile_avatar.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/appearance_card.dart';
import '../widgets/data_card.dart';
import '../widgets/motion_card.dart';
import '../widgets/notifications_card.dart';
import '../widgets/profile_card.dart';

/// The Settings tab: profile, appearance, motion, notifications and data.
class SettingsScreen extends ConsumerWidget {
  /// Creates the settings screen.
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
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
                AnjizSpacing.xxl,
              ),
              sliver: SliverList.list(
                children: [
                  ProfileCard(onManagePlan: () => _soon(context, l10n)),
                  const SizedBox(height: AnjizSpacing.md),
                  const AppearanceCard(),
                  const SizedBox(height: AnjizSpacing.md),
                  const MotionCard(),
                  const SizedBox(height: AnjizSpacing.md),
                  NotificationsCard(
                    onOpenWidgetConfig: () =>
                        context.push(AppRoutes.widgetConfig),
                  ),
                  const SizedBox(height: AnjizSpacing.md),
                  DataCard(
                    onCalendarOptions: () => _soon(context, l10n),
                    onExport: (format) => AnjizSnackBar.show(
                      context,
                      message: l10n.exportStarted,
                    ),
                  ),
                  const SizedBox(height: AnjizSpacing.lg),
                  const _Footer(version: AppConstants.version),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _soon(BuildContext context, AppLocalizations l10n) =>
      AnjizSnackBar.show(context, message: l10n.comingSoon);
}

class _Footer extends StatelessWidget {
  const _Footer({required this.version});

  final String version;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Column(
      children: [
        Text(
          l10n.footerVersion(version),
          textAlign: TextAlign.center,
          style: textTheme.labelSmall?.copyWith(color: color),
        ),
        const SizedBox(height: AnjizSpacing.xs),
        Text(
          l10n.footerTagline,
          textAlign: TextAlign.center,
          style: textTheme.labelSmall?.copyWith(color: color),
        ),
      ],
    );
  }
}

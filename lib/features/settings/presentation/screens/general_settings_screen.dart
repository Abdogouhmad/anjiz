import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/settings_controller.dart';
import '../settings_summaries.dart';
import '../widgets/settings_sub_screen.dart';

/// The General section: theme and motion controls, each on its own screen.
class GeneralSettingsScreen extends ConsumerWidget {
  /// Creates the General section screen.
  const GeneralSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    return SettingsSubScreen(
      title: l10n.settingsGeneralTitle,
      subtitle: l10n.settingsGeneralSubtitle,
      children: [
        AnjizSettingsNavGroup(
          entries: [
            AnjizSettingsNavEntry(
              icon: Icons.palette_outlined,
              title: l10n.themeSettingsTitle,
              subtitle: themeSummary(l10n, settings),
              onTap: () => context.go(AppRoutes.settingsTheme),
            ),
            AnjizSettingsNavEntry(
              icon: Icons.auto_awesome_outlined,
              tone: AnjizTone.secondary,
              title: l10n.motionSettingsTitle,
              subtitle: hapticSummary(l10n, settings),
              onTap: () => context.go(AppRoutes.settingsMotion),
            ),
            AnjizSettingsNavEntry(
              icon: Icons.timer_outlined,
              tone: AnjizTone.tertiary,
              title: l10n.settingsFocusTitle,
              subtitle: focusSummary(l10n, settings),
              onTap: () => context.go(AppRoutes.settingsFocus),
            ),
          ],
        ),
      ],
    );
  }
}

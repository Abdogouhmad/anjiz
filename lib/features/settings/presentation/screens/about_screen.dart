import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/app_info.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/about_card.dart';
import '../widgets/settings_sub_screen.dart';

/// About: app identity, architecture highlights and the open-source licences.
class AboutScreen extends StatelessWidget {
  /// Creates the about screen.
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SettingsSubScreen(
      title: l10n.settingsAboutTitle,
      subtitle: l10n.settingsAboutSubtitle,
      children: [
        const AboutCard(),
        const SizedBox(height: AnjizSpacing.md),
        AnjizSectionHeader(title: l10n.aboutHighlightsTitle),
        AnjizSettingsNavGroup(
          entries: [
            AnjizSettingsNavEntry(
              icon: Icons.storage_rounded,
              tone: AnjizTone.primary,
              title: l10n.aboutHighlightOffline,
              subtitle: 'Drift 2.28 + SQLite',
              onTap: () {},
            ),
            AnjizSettingsNavEntry(
              icon: Icons.animation_rounded,
              tone: AnjizTone.secondary,
              title: l10n.aboutHighlightExpressive,
              subtitle: 'M3 spring tokens & scalloped shapes',
              onTap: () {},
            ),
            AnjizSettingsNavEntry(
              icon: Icons.widgets_outlined,
              tone: AnjizTone.tertiary,
              title: l10n.aboutHighlightWidgets,
              subtitle: 'Tasks Overview 4x4, Compact & Progress',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: AnjizSpacing.md),
        AnjizSectionHeader(title: l10n.settingsLegal),
        AnjizSettingsNavGroup(
          entries: [
            AnjizSettingsNavEntry(
              icon: Icons.gavel_rounded,
              tone: AnjizTone.neutral,
              title: l10n.aboutLicences,
              subtitle: l10n.aboutLicencesSubtitle,
              onTap: () => showLicensePage(
                context: context,
                applicationName: l10n.appTitle,
                applicationVersion: AppInfo.version,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

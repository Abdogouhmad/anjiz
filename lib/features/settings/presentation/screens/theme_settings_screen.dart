import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../widgets/appearance_sections.dart';
import '../widgets/settings_sub_screen.dart';

/// Theme controls: colour mode, dynamic colour, pure black and accent tone.
class ThemeSettingsScreen extends StatelessWidget {
  /// Creates the theme settings screen.
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SettingsSubScreen(
      title: l10n.themeSettingsTitle,
      subtitle: l10n.themeSettingsSubtitle,
      children: const [AppearanceSections()],
    );
  }
}

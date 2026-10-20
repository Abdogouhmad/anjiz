import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../widgets/focus_sections.dart';
import '../widgets/settings_sub_screen.dart';

/// Focus settings: Pomodoro lengths, long-break rhythm and auto-start.
class FocusSettingsScreen extends StatelessWidget {
  /// Creates the focus settings screen.
  const FocusSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SettingsSubScreen(
      title: l10n.settingsFocusTitle,
      subtitle: l10n.settingsFocusSubtitle,
      children: const [FocusSections()],
    );
  }
}

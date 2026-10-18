import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../widgets/data_sections.dart';
import '../widgets/settings_sub_screen.dart';

/// Data settings: calendar connection and task history export.
class DataSettingsScreen extends StatelessWidget {
  /// Creates the data settings screen.
  const DataSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SettingsSubScreen(
      title: l10n.dataTitle,
      subtitle: l10n.settingsDataSubtitle,
      children: [
        DataSections(
          onCalendarOptions: () =>
              AnjizSnackBar.show(context, message: l10n.comingSoon),
          onExport: (format) =>
              AnjizSnackBar.show(context, message: l10n.exportStarted),
        ),
      ],
    );
  }
}

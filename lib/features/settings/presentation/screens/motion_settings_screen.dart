import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../widgets/motion_sections.dart';
import '../widgets/settings_sub_screen.dart';

/// Motion controls: scalloped burst animations and spring haptic intensity.
class MotionSettingsScreen extends StatelessWidget {
  /// Creates the motion settings screen.
  const MotionSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SettingsSubScreen(
      title: l10n.motionSettingsTitle,
      subtitle: l10n.motionSettingsSubtitle,
      children: const [MotionSections()],
    );
  }
}

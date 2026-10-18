import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/accent_tones.dart';
import '../providers/settings_controller.dart';
import 'theme_preview_card.dart';

/// The Theme screen body: a live preview card, brightness controls and colour palettes.
class AppearanceSections extends ConsumerWidget {
  /// Creates the theme sections.
  const AppearanceSections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ThemePreviewCard(),
        const SizedBox(height: AnjizSpacing.md),
        AnjizSectionHeader(title: l10n.settingsBrightness),
        AnjizSettingsCard(
          children: [
            AnjizSegmentedSelector<ThemeMode>(
              selected: settings.themeMode,
              onChanged: (mode) => controller.setThemeMode(mode),
              segments: [
                (
                  value: ThemeMode.system,
                  label: l10n.themeSystem,
                  icon: Icons.brightness_auto_outlined,
                ),
                (
                  value: ThemeMode.light,
                  label: l10n.themeLight,
                  icon: Icons.light_mode_outlined,
                ),
                (
                  value: ThemeMode.dark,
                  label: l10n.themeDark,
                  icon: Icons.dark_mode_outlined,
                ),
              ],
            ),
            AnjizSwitchTile(
              title: l10n.labelPureBlack,
              subtitle: isDark
                  ? l10n.pureBlackSubtitle
                  : l10n.settingsPureBlackUnavailable,
              value: settings.usePureBlack,
              switchSemanticLabel: l10n.labelPureBlack,
              onChanged: isDark
                  ? (value) => controller.setPureBlack(enabled: value)
                  : null,
            ),
          ],
        ),
        const SizedBox(height: AnjizSpacing.md),
        AnjizSectionHeader(
          title: l10n.settingsColour,
          trailing: AnjizTagPill(
            label: accentLabel(l10n, settings.accentIndex),
            tone: AnjizTone.secondary,
          ),
        ),
        AnjizSettingsCard(
          children: [
            AnjizSwitchTile(
              title: l10n.labelDynamicColor,
              subtitle: l10n.dynamicColorSubtitle,
              value: settings.useDynamicColor,
              switchSemanticLabel: l10n.labelDynamicColor,
              onChanged: (value) => controller.setDynamicColor(enabled: value),
            ),
            AnjizColorSwatches(
              swatches: [
                for (var i = 0; i < kAccentSeeds.length; i++)
                  (color: kAccentSeeds[i], label: accentLabel(l10n, i)),
              ],
              selectedIndex: settings.accentIndex,
              onSelected: (index) => controller.setAccentIndex(index),
            ),
          ],
        ),
      ],
    );
  }
}

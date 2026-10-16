import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/accent_tones.dart';
import '../providers/settings_controller.dart';

/// The "Appearance & Theme" settings card.
class AppearanceCard extends ConsumerWidget {
  /// Creates the appearance card.
  const AppearanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
      letterSpacing: 1,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
    return AnjizSettingsCard(
      icon: Icons.palette_outlined,
      title: l10n.appearanceTitle,
      trailing: AnjizTagPill(
        label: l10n.tagMaterialYou,
        tone: AnjizTone.primary,
      ),
      children: [
        AnjizSwitchTile(
          title: l10n.labelDynamicColor,
          subtitle: l10n.dynamicColorSubtitle,
          value: settings.useDynamicColor,
          switchSemanticLabel: l10n.labelDynamicColor,
          onChanged: (value) => controller.setDynamicColor(enabled: value),
        ),
        const SizedBox(height: AnjizSpacing.lg),
        Text(l10n.labelThemeMode.toUpperCase(), style: labelStyle),
        const SizedBox(height: AnjizSpacing.sm),
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
        const SizedBox(height: AnjizSpacing.lg),
        Row(
          children: [
            Text(l10n.labelAccentTone.toUpperCase(), style: labelStyle),
            const Spacer(),
            AnjizTagPill(
              label: accentLabel(l10n, settings.accentIndex),
              tone: AnjizTone.secondary,
            ),
          ],
        ),
        const SizedBox(height: AnjizSpacing.md),
        AnjizColorSwatches(
          swatches: [
            for (var i = 0; i < kAccentSeeds.length; i++)
              (color: kAccentSeeds[i], label: accentLabel(l10n, i)),
          ],
          selectedIndex: settings.accentIndex,
          onSelected: (index) => controller.setAccentIndex(index),
        ),
      ],
    );
  }
}

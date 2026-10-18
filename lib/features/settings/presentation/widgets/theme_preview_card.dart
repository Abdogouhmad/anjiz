import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Live preview card on the Theme screen showing how buttons and controls
/// render with the currently selected palette, mode, and brightness.
class ThemePreviewCard extends StatelessWidget {
  /// Creates the theme preview card.
  const ThemePreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AnjizCard(
      elevated: true,
      padding: const EdgeInsets.all(AnjizSpacing.md20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const AnjizIconBadge(
                icon: Icons.preview_rounded,
                tone: AnjizTone.primary,
                size: 36,
                iconSize: 18,
              ),
              const SizedBox(width: AnjizSpacing.md12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.themePreviewTitle, style: textTheme.titleMedium),
                    Text(
                      l10n.themePreviewSubtitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.md),
          Container(
            padding: const EdgeInsets.all(AnjizSpacing.md12),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AnjizShapes.medium),
            ),
            child: Row(
              children: [
                const AnjizTaskCheckbox(value: true),
                const SizedBox(width: AnjizSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.themePreviewTitle,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                AnjizPriorityChip(label: l10n.themeChipTask),
              ],
            ),
          ),
          const SizedBox(height: AnjizSpacing.md),
          Row(
            children: [
              Expanded(
                child: AnjizButton(
                  label: l10n.themeButtonPrimary,
                  icon: Icons.check_circle_outline_rounded,
                  variant: AnjizButtonVariant.filled,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: AnjizSpacing.sm),
              Expanded(
                child: AnjizButton(
                  label: l10n.themeButtonTonal,
                  icon: Icons.palette_outlined,
                  variant: AnjizButtonVariant.tonal,
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.sm),
          AnjizButton(
            label: l10n.themeButtonOutlined,
            icon: Icons.tune_rounded,
            variant: AnjizButtonVariant.outlined,
            expand: true,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

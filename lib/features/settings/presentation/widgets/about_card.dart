import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/app_info.dart';
import '../../../../l10n/app_localizations.dart';

/// The redesigned app identity card on the About screen with the real app icon,
/// comprehensive description, and author attribution.
class AboutCard extends StatelessWidget {
  /// Creates the about card.
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AnjizCard(
      elevated: true,
      padding: const EdgeInsets.all(AnjizSpacing.xl),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: scheme.primary.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/icon/ic_playstore_512.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: AnjizSpacing.md),
          Text(
            l10n.appTitle,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AnjizSpacing.xs),
          AnjizTagPill(
            label: 'v${AppInfo.version}',
            tone: AnjizTone.primary,
            compact: true,
          ),
          const SizedBox(height: AnjizSpacing.md),
          Text(
            l10n.aboutAppDescription,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AnjizSpacing.md12),
          Divider(
            height: 1,
            color: scheme.outlineVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AnjizSpacing.md12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.code_rounded,
                size: 16,
                color: scheme.onSurfaceVariant,
              ),
              const SizedBox(width: AnjizSpacing.xs),
              Flexible(
                child: Text(
                  l10n.aboutAuthor,
                  textAlign: TextAlign.center,
                  style: textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

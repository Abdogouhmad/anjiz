import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/profile_avatar.dart';
import '../../../../l10n/app_localizations.dart';

/// The redesigned profile hero card on the settings screen.
class ProfileCard extends StatelessWidget {
  /// Creates the profile card.
  const ProfileCard({required this.onManagePlan, super.key});

  /// Called when "Manage Plan" is tapped.
  final VoidCallback onManagePlan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnjizCard(
      elevated: true,
      padding: const EdgeInsets.all(AnjizSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  const ProfileAvatar(size: 60),
                  PositionedDirectional(
                    bottom: 0,
                    end: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_rounded,
                          size: 12,
                          color: scheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AnjizSpacing.md12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.profileName,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.profileEmail,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              AnjizTagPill(
                label: l10n.proSyncActive,
                tone: AnjizTone.primary,
                icon: Icons.cloud_done_outlined,
                compact: true,
              ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.md),
          Divider(
            height: 1,
            color: scheme.outlineVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AnjizSpacing.md),
          Row(
            children: [
              Expanded(
                child: AnjizButton(
                  label: l10n.actionManagePlan,
                  icon: Icons.star_rounded,
                  variant: AnjizButtonVariant.tonal,
                  onPressed: onManagePlan,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

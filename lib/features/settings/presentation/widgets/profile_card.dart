import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/profile_avatar.dart';
import '../../../../l10n/app_localizations.dart';

/// The profile header on the settings screen.
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const ProfileAvatar(size: 52),
              const SizedBox(width: AnjizSpacing.md12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.profileName, style: textTheme.titleMedium),
                    Text(
                      l10n.profileEmail,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
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
          const SizedBox(height: AnjizSpacing.sm),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: onManagePlan,
              child: Text(l10n.actionManagePlan),
            ),
          ),
        ],
      ),
    );
  }
}

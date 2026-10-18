import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/widgets/profile_avatar.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/profile_controller.dart';

/// The profile hero card on the settings screen: real local data, one action.
class ProfileCard extends ConsumerWidget {
  /// Creates the profile card.
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final profile = ref.watch(profileProvider);

    return AnjizCard(
      elevated: true,
      padding: const EdgeInsets.all(AnjizSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const ProfileAvatar(size: 60),
              const SizedBox(width: AnjizSpacing.md12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name.isEmpty
                          ? l10n.profileNameMissing
                          : profile.name,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profile.email.isEmpty
                          ? l10n.profileLocalOnly
                          : profile.email,
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
                label: l10n.profileLocalTag,
                tone: AnjizTone.neutral,
                icon: Icons.offline_bolt_outlined,
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
          AnjizButton(
            label: l10n.profileEditAction,
            icon: Icons.edit_rounded,
            variant: AnjizButtonVariant.tonal,
            expand: true,
            onPressed: () => context.go(AppRoutes.settingsProfile),
          ),
        ],
      ),
    );
  }
}

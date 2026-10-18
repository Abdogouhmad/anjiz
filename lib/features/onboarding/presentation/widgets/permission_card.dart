import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// A single permission row: icon, copy, live status pill and grant action.
///
/// Shared by onboarding and the notification settings so the two flows
/// request access identically.
class PermissionCard extends StatelessWidget {
  /// Creates a permission card.
  const PermissionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.granted,
    required this.onRequest,
    super.key,
  });

  /// Leading icon.
  final IconData icon;

  /// Permission name.
  final String title;

  /// Why the app asks for it.
  final String subtitle;

  /// Current status: `null` while unknown, then granted/denied.
  final bool? granted;

  /// Triggers the platform permission prompt.
  final VoidCallback onRequest;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isGranted = granted ?? false;
    return AnjizCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              AnjizIconBadge(
                icon: icon,
                tone: isGranted ? AnjizTone.primary : AnjizTone.neutral,
                size: 40,
                iconSize: 20,
              ),
              const SizedBox(width: AnjizSpacing.md12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (granted != null) ...[
                const SizedBox(width: AnjizSpacing.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 110),
                  child: AnjizTagPill(
                    label: isGranted
                        ? l10n.notificationsPermissionGranted
                        : l10n.notificationsPermissionDenied,
                    tone: isGranted ? AnjizTone.primary : AnjizTone.error,
                    compact: true,
                  ),
                ),
              ],
            ],
          ),
          if (granted != null && !isGranted) ...[
            const SizedBox(height: AnjizSpacing.md),
            AnjizButton(
              label: l10n.notificationsGrantAction,
              icon: Icons.shield_outlined,
              variant: AnjizButtonVariant.tonal,
              expand: true,
              onPressed: onRequest,
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// The "Daily Milestone Momentum" summary card at the bottom of the Lists grid.
class DailyMilestoneCard extends StatelessWidget {
  /// Creates the milestone card.
  const DailyMilestoneCard({
    required this.completedToday,
    required this.progress,
    super.key,
  });

  /// Number of tasks completed today across every list.
  final int completedToday;

  /// Share of today's tasks that are done (0.0–1.0).
  final double progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return AnjizCard(
      padding: const EdgeInsets.all(AnjizSpacing.md20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AnjizIconBadge(
                icon: Icons.workspace_premium_outlined,
                tone: AnjizTone.primary,
                size: 40,
                iconSize: 20,
              ),
              const SizedBox(width: AnjizSpacing.md12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.dailyMilestoneTitle,
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      l10n.dailyMilestoneSubtitle(completedToday),
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              AnjizTagPill(
                label: l10n.labelXpEarned(completedToday * 10),
                tone: AnjizTone.tertiary,
              ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.md),
          AnjizWavyProgress(value: progress),
        ],
      ),
    );
  }
}

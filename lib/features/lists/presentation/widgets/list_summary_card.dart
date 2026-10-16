import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/task_list_summary.dart';
import 'task_list_icons.dart';

/// The large tonal card representing one task list on the Lists overview.
class ListSummaryCard extends StatelessWidget {
  /// Creates a list summary card.
  const ListSummaryCard({
    required this.summary,
    required this.onTap,
    this.featured = false,
    super.key,
  });

  /// The list plus its aggregate counts.
  final TaskListSummary summary;

  /// Called when the card is tapped.
  final VoidCallback onTap;

  /// Renders the card in the higher-contrast featured treatment.
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accent = Color(summary.list.color);
    final background = featured
        ? scheme.primary
        : Color.alphaBlend(
            accent.withValues(alpha: 0.16),
            scheme.surfaceContainerLowest,
          );
    final foreground = featured ? scheme.onPrimary : scheme.onSurface;
    final muted = featured
        ? scheme.onPrimary.withValues(alpha: 0.78)
        : scheme.onSurfaceVariant;
    final percent = (summary.progress * 100).round();
    return AnjizCard(
      color: background,
      padding: const EdgeInsets.all(AnjizSpacing.md20),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnjizIconBadge(
                icon: taskListIcon(summary.list.icon),
                tone: AnjizTone.primary,
                size: 40,
                iconSize: 20,
              ),
              const Spacer(),
              AnjizTagPill(
                label: l10n.tasksRemaining(summary.remaining),
                tone: AnjizTone.neutral,
              ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.md12),
          Text(
            summary.list.name,
            style: textTheme.titleLarge?.copyWith(color: foreground),
          ),
          const SizedBox(height: AnjizSpacing.xs),
          Text(
            l10n.tasksCount(summary.total),
            style: textTheme.bodyMedium?.copyWith(color: muted),
          ),
          const SizedBox(height: AnjizSpacing.md),
          Row(
            children: [
              Text(
                l10n.labelProgress,
                style: textTheme.labelLarge?.copyWith(color: muted),
              ),
              const Spacer(),
              Text(
                l10n.labelPercent(percent),
                style: textTheme.labelLarge?.copyWith(color: foreground),
              ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.sm),
          AnjizWavyProgress(
            value: summary.progress,
            color: featured ? scheme.onPrimary : scheme.primary,
          ),
        ],
      ),
    );
  }
}

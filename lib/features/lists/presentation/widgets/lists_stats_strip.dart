import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// The three stat pills above the Lists grid: projects, active tasks and
/// weekly velocity.
class ListsStatsStrip extends StatelessWidget {
  /// Creates the stats strip.
  const ListsStatsStrip({
    required this.projects,
    required this.activeTasks,
    required this.weeklyVelocity,
    super.key,
  });

  /// Number of lists.
  final int projects;

  /// Number of open tasks across every list.
  final int activeTasks;

  /// Velocity ratio across the week (0.0–1.0).
  final double weeklyVelocity;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // The strip lives inside a sliver, so its height is unbounded; the pills
    // must share the tallest one's height explicitly, otherwise
    // `CrossAxisAlignment.stretch` has nothing to stretch against and the
    // render tree fails to lay out.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _StatPill(
              icon: Icons.folder_outlined,
              value: '$projects',
              label: l10n.labelProjects,
              tone: AnjizTone.primary,
            ),
          ),
          const SizedBox(width: AnjizSpacing.sm),
          Expanded(
            child: _StatPill(
              icon: Icons.check_circle_outline,
              value: '$activeTasks',
              label: l10n.labelActiveTasks,
              tone: AnjizTone.secondary,
            ),
          ),
          const SizedBox(width: AnjizSpacing.sm),
          Expanded(
            child: _StatPill(
              icon: Icons.bolt_rounded,
              value: l10n.labelPercent((weeklyVelocity * 100).round()),
              label: l10n.labelWeeklyVelocity,
              tone: AnjizTone.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.icon,
    required this.value,
    required this.label,
    required this.tone,
  });

  final IconData icon;
  final String value;
  final String label;
  final AnjizTone tone;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AnjizCard(
      padding: const EdgeInsets.all(AnjizSpacing.md12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnjizIconBadge(icon: icon, tone: tone, size: 32, iconSize: 16),
          const SizedBox(height: AnjizSpacing.sm),
          Text(value, style: textTheme.titleMedium),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

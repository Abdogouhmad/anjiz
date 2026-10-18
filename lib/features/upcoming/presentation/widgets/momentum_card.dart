import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/upcoming_agenda.dart';
import '../../../../l10n/app_localizations.dart';

/// The "Weekly Momentum" card: how much of the next seven days carries work.
class MomentumCard extends StatelessWidget {
  /// Creates the momentum card.
  const MomentumCard({required this.agenda, super.key});

  /// The upcoming agenda powering the ratio.
  final UpcomingAgenda agenda;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final percent = (agenda.momentum * 100).round();
    return AnjizCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AnjizIconBadge(
                icon: Icons.auto_awesome_rounded,
                tone: AnjizTone.primary,
                size: 36,
                iconSize: 18,
              ),
              const SizedBox(width: AnjizSpacing.md12),
              Expanded(
                child: Text(
                  l10n.momentumTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                l10n.momentumScheduled(percent),
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(color: scheme.primary),
              ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.md),
          AnjizWavyProgress(value: agenda.momentum),
          if (agenda.total == 0) ...[
            const SizedBox(height: AnjizSpacing.sm),
            Text(
              l10n.momentumEmptyMessage,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

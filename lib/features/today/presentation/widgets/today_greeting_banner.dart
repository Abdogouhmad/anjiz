import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// The expressive greeting banner at the top of the Today screen.
class TodayGreetingBanner extends StatelessWidget {
  /// Creates the greeting banner.
  const TodayGreetingBanner({required this.remaining, super.key});

  /// Number of tasks still open today.
  final int remaining;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hour = DateTime.now().hour;
    final greeting = switch (hour) {
      < 12 => l10n.greetingMorning,
      < 17 => l10n.greetingAfternoon,
      _ => l10n.greetingEvening,
    };
    return AnjizCard(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Row(
        children: [
          const AnjizIconBadge(
            icon: Icons.eco_rounded,
            tone: AnjizTone.primary,
            size: 44,
            iconSize: 22,
          ),
          const SizedBox(width: AnjizSpacing.md12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: AnjizSpacing.xs),
                Text(
                  l10n.todaySummary(remaining),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

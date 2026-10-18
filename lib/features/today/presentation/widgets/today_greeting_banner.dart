import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// The expressive greeting banner at the top of the Today screen.
class TodayGreetingBanner extends StatelessWidget {
  /// Creates the greeting banner.
  const TodayGreetingBanner({
    required this.remaining,
    this.name = '',
    super.key,
  });

  /// Number of tasks still open today.
  final int remaining;

  /// Profile first name, personalising the greeting when present.
  final String name;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return AnjizCard(
      color: scheme.secondaryContainer,
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
                  _greeting(l10n),
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(color: scheme.onSecondaryContainer),
                ),
                const SizedBox(height: AnjizSpacing.xs),
                Text(
                  l10n.todaySummary(remaining),
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: scheme.onSecondaryContainer),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// "Good morning, Sarah!" when a name exists, plain greeting otherwise.
  String _greeting(AppLocalizations l10n) {
    final first = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    final given = first.isEmpty ? '' : first.first;
    final hour = DateTime.now().hour;
    if (given.isEmpty) {
      return switch (hour) {
        < 12 => l10n.greetingMorning,
        < 17 => l10n.greetingAfternoon,
        _ => l10n.greetingEvening,
      };
    }
    return switch (hour) {
      < 12 => l10n.greetingMorningNamed(given),
      < 17 => l10n.greetingAfternoonNamed(given),
      _ => l10n.greetingEveningNamed(given),
    };
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// The dashed "New Project" tile that terminates the Lists grid.
class NewListCard extends StatelessWidget {
  /// Creates the new-list tile.
  const NewListCard({required this.onTap, super.key});

  /// Called when the tile is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AnjizCard(
      color: scheme.surfaceContainerLow,
      padding: const EdgeInsets.all(AnjizSpacing.md20),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AnjizIconBadge(
            icon: Icons.add_rounded,
            tone: AnjizTone.secondary,
            size: 48,
            iconSize: 24,
          ),
          const SizedBox(height: AnjizSpacing.md12),
          Text(l10n.newProjectTitle, style: textTheme.titleMedium),
          const SizedBox(height: AnjizSpacing.xs),
          Text(
            l10n.newProjectSubtitle,
            textAlign: TextAlign.center,
            style: textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

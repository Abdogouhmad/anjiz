import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';
import '../lists/anjiz_card.dart';
import '../lists/anjiz_icon_badge.dart';
import 'anjiz_settings_nav_entry.dart';
import 'anjiz_settings_nav_tile.dart';

/// A card of tappable settings rows that each open a nested screen — the
/// building block of a settings hub.
class AnjizSettingsNavGroup extends StatelessWidget {
  /// Creates a settings navigation group.
  const AnjizSettingsNavGroup({required this.entries, super.key});

  /// The rows, in display order.
  final List<AnjizSettingsNavEntry> entries;

  @override
  Widget build(BuildContext context) {
    return AnjizCard(
      padding: const EdgeInsets.all(AnjizSpacing.md12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < entries.length; i++) ...[
            if (i != 0) const SizedBox(height: AnjizSpacing.md12),
            AnjizSettingsNavTile(
              title: entries[i].title,
              subtitle: entries[i].subtitle,
              leading: AnjizIconBadge(
                icon: entries[i].icon,
                tone: entries[i].tone,
                size: 36,
                iconSize: 18,
              ),
              trailing: entries[i].trailing,
              onTap: entries[i].onTap,
            ),
          ],
        ],
      ),
    );
  }
}

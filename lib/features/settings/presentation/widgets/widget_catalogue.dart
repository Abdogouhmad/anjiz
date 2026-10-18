import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// The catalogue of available home-screen widgets, shown above the settings.
class WidgetCatalogue extends StatelessWidget {
  /// Creates the widget catalogue.
  const WidgetCatalogue({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entries = <({IconData icon, String title, String subtitle})>[
      (
        icon: Icons.checklist_rtl_rounded,
        title: l10n.widgetOverviewTitle,
        subtitle: l10n.widgetOverviewSubtitle,
      ),
      (
        icon: Icons.view_agenda_outlined,
        title: l10n.widgetCompactTitle,
        subtitle: l10n.widgetCompactSubtitle,
      ),
      (
        icon: Icons.donut_large_rounded,
        title: l10n.widgetProgressTitle,
        subtitle: l10n.widgetProgressSubtitle,
      ),
      (
        icon: Icons.bolt_rounded,
        title: l10n.widgetQuickAddTitle,
        subtitle: l10n.widgetQuickAddSubtitle,
      ),
    ];
    return AnjizCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < entries.length; i++) ...[
            if (i > 0) const SizedBox(height: AnjizSpacing.md12),
            AnjizListTile(
              leading: AnjizIconBadge(
                icon: entries[i].icon,
                tone: AnjizTone.secondary,
                size: 36,
                iconSize: 18,
              ),
              title: Text(entries[i].title),
              subtitle: Text(entries[i].subtitle),
              trailing: AnjizTagPill(label: l10n.previewLabel),
            ),
          ],
        ],
      ),
    );
  }
}

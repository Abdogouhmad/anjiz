import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// The Data screen body: a "Calendar" group (the Google Calendar connection)
/// and an "Export" group of task-history formats.
class DataSections extends StatelessWidget {
  /// Creates the data sections.
  const DataSections({
    required this.onCalendarOptions,
    required this.onExport,
    super.key,
  });

  /// Opens the calendar connection options.
  final VoidCallback onCalendarOptions;

  /// Starts an export in the given localised format label.
  final void Function(String format) onExport;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnjizSectionHeader(title: l10n.settingsCalendar),
        AnjizSettingsCard(
          children: [
            AnjizSettingsNavTile(
              title: l10n.labelGoogleCalendar,
              subtitle: l10n.profileEmail,
              leading: const AnjizIconBadge(
                icon: Icons.event_available_outlined,
                tone: AnjizTone.primary,
                size: 36,
                iconSize: 18,
              ),
              trailing: TextButton(
                onPressed: onCalendarOptions,
                child: Text(l10n.actionOptions),
              ),
              onTap: onCalendarOptions,
            ),
          ],
        ),
        const SizedBox(height: AnjizSpacing.md),
        AnjizSectionHeader(title: l10n.settingsExport),
        AnjizSettingsCard(
          children: [
            Row(
              children: [
                _ExportButton(
                  icon: Icons.data_object_rounded,
                  label: l10n.exportJson,
                  onPressed: () => onExport(l10n.exportJson),
                ),
                const SizedBox(width: AnjizSpacing.sm),
                _ExportButton(
                  icon: Icons.article_outlined,
                  label: l10n.exportMarkdown,
                  onPressed: () => onExport(l10n.exportMarkdown),
                ),
                const SizedBox(width: AnjizSpacing.sm),
                _ExportButton(
                  icon: Icons.table_chart_outlined,
                  label: l10n.exportCsv,
                  onPressed: () => onExport(l10n.exportCsv),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ExportButton extends StatelessWidget {
  const _ExportButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnjizButton(
        label: label,
        icon: icon,
        variant: AnjizButtonVariant.tonal,
        size: AnjizButtonSize.small,
        onPressed: onPressed,
      ),
    );
  }
}

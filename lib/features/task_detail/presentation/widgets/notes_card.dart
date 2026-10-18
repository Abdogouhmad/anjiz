import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// The "Notes & Brief" card on the task-detail screen.
class NotesCard extends StatelessWidget {
  /// Creates the notes card.
  const NotesCard({required this.notes, required this.onEdit, super.key});

  /// The task's note body.
  final String notes;

  /// Called when the card is tapped to edit the notes.
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasNotes = notes.trim().isNotEmpty;
    return AnjizCard(
      onTap: onEdit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnjizListTile(
            leading: const AnjizIconBadge(
              icon: Icons.notes_rounded,
              tone: AnjizTone.secondary,
              size: 36,
              iconSize: 18,
            ),
            title: Text(l10n.sectionNotes),
            trailing: Icon(
              Icons.edit_outlined,
              size: 18,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AnjizSpacing.sm),
          Text(
            hasNotes ? notes : l10n.labelTapToEdit,
            style: textTheme.bodyLarge?.copyWith(
              color: hasNotes ? scheme.onSurface : scheme.onSurfaceVariant,
              fontStyle: hasNotes ? FontStyle.normal : FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

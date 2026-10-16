import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../widgets/task_recurrence.dart';

/// Shows a sheet to choose a repeat rule, returning the picked token.
Future<String?> showRepeatPicker(BuildContext context, String? current) {
  final l10n = AppLocalizations.of(context);
  final selected = current ?? RepeatRules.none;
  return AnjizBottomSheet.show<String>(
    context,
    child: AnjizSheetContent(
      title: l10n.labelRecurrence,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final choice in RepeatRules.choices)
            AnjizListTile(
              leading: AnjizIconBadge(
                icon: choice == RepeatRules.none
                    ? Icons.block_rounded
                    : Icons.repeat_rounded,
                tone: choice == selected
                    ? AnjizTone.primary
                    : AnjizTone.neutral,
                size: 36,
                iconSize: 18,
              ),
              title: Text(RepeatRules.label(l10n, choice)),
              trailing: choice == selected
                  ? const Icon(Icons.check_rounded)
                  : null,
              onTap: () => Navigator.of(context).pop(choice),
            ),
        ],
      ),
    ),
  );
}

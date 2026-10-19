import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Asks whether to replace the running focus session with this task.
///
/// Returns false when the sheet is dismissed without a choice.
Future<bool> confirmFocusSwitch(BuildContext context) async {
  final l10n = AppLocalizations.of(context);
  final result = await AnjizBottomSheet.show<bool>(
    context,
    child: AnjizSheetContent(
      title: l10n.pomodoroTitle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.pomodoroSwitchPrompt,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AnjizSpacing.lg),
          AnjizButton(
            label: l10n.pomodoroStartFocus,
            icon: Icons.play_arrow_rounded,
            expand: true,
            onPressed: () => Navigator.of(context).pop(true),
          ),
          const SizedBox(height: AnjizSpacing.sm),
          AnjizButton(
            label: l10n.actionCancel,
            variant: AnjizButtonVariant.text,
            expand: true,
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    ),
  );
  return result ?? false;
}

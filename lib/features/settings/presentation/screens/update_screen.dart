import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/update_controller.dart';
import '../widgets/release_notes_card.dart';
import '../widgets/settings_sub_screen.dart';
import '../widgets/update_card.dart';

/// App update screen inspired by Walt's OTA update center.
class UpdateScreen extends ConsumerWidget {
  /// Creates the update screen.
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final notes = ref.watch(updateControllerProvider).manifest?.releaseNotes;
    return SettingsSubScreen(
      title: l10n.updateTitle,
      subtitle: l10n.updateSubtitle,
      children: [
        const UpdateCard(),
        if (notes != null && notes.trim().isNotEmpty) ...[
          const SizedBox(height: AnjizSpacing.md),
          AnjizSectionHeader(title: l10n.updateWhatsNew),
          ReleaseNotesCard(notes: notes),
        ],
      ],
    );
  }
}

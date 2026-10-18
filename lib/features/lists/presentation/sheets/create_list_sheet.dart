import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/use_case_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/task_list_colors.dart';
import '../widgets/task_list_icons.dart';

/// Opens the "New List" modal sheet.
Future<void> showCreateListSheet(BuildContext context) =>
    AnjizBottomSheet.show<void>(context, child: const CreateListSheet());

/// The New List sheet: name, accent colour and icon.
class CreateListSheet extends ConsumerStatefulWidget {
  /// Creates the sheet.
  const CreateListSheet({super.key});

  @override
  ConsumerState<CreateListSheet> createState() => _CreateListSheetState();
}

class _CreateListSheetState extends ConsumerState<CreateListSheet> {
  final TextEditingController _name = TextEditingController();
  int _colorIndex = 0;
  String _icon = kTaskListIconChoices.first;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final name = _name.text.trim();
    if (name.isEmpty) {
      AnjizSnackBar.show(context, message: l10n.errorValidationMessage);
      return;
    }
    setState(() => _saving = true);
    await ref
        .read(createTaskListProvider)
        .call(
          name: name,
          color: kTaskListColors[_colorIndex],
          icon: _icon,
          sortOrder: DateTime.now().millisecondsSinceEpoch,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
      letterSpacing: 1,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
    return AnjizSheetContent(
      title: l10n.actionNewList,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnjizTextField(
            controller: _name,
            autofocus: true,
            hintText: l10n.labelListName,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: AnjizSpacing.lg),
          Text(l10n.labelListColor.toUpperCase(), style: labelStyle),
          const SizedBox(height: AnjizSpacing.sm),
          AnjizColorSwatches(
            swatches: [
              for (final color in kTaskListColors)
                (color: color, label: _colorLabel(l10n, color)),
            ],
            selectedIndex: _colorIndex,
            onSelected: (index) => setState(() => _colorIndex = index),
          ),
          const SizedBox(height: AnjizSpacing.lg),
          Text(l10n.labelListIcon.toUpperCase(), style: labelStyle),
          const SizedBox(height: AnjizSpacing.sm),
          Wrap(
            spacing: AnjizSpacing.sm,
            runSpacing: AnjizSpacing.sm,
            children: [
              for (final icon in kTaskListIconChoices)
                InkWell(
                  onTap: () => setState(() => _icon = icon),
                  customBorder: const CircleBorder(),
                  child: Semantics(
                    selected: icon == _icon,
                    button: true,
                    child: AnjizIconBadge(
                      icon: taskListIcon(icon),
                      tone: icon == _icon
                          ? AnjizTone.primary
                          : AnjizTone.neutral,
                      size: 44,
                      iconSize: 22,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.xl),
          AnjizButton(
            label: l10n.actionCreateList,
            icon: Icons.add_rounded,
            loading: _saving,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  String _colorLabel(AppLocalizations l10n, int color) {
    final index = kTaskListColors.indexOf(color);
    return switch (index) {
      0 => l10n.accentEmerald,
      1 => l10n.accentOcean,
      2 => l10n.accentTerracotta,
      3 => l10n.accentLavender,
      _ => l10n.accentSand,
    };
  }
}

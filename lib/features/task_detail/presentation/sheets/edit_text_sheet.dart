import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Opens a single-field edit sheet, returning the new text or `null`.
Future<String?> showEditTextSheet(
  BuildContext context, {
  required String title,
  required String initial,
  String? hint,
  int maxLines = 1,
}) => AnjizBottomSheet.show<String>(
  context,
  child: _EditTextSheet(
    title: title,
    initial: initial,
    hint: hint,
    maxLines: maxLines,
  ),
);

class _EditTextSheet extends StatefulWidget {
  const _EditTextSheet({
    required this.title,
    required this.initial,
    required this.hint,
    required this.maxLines,
  });

  final String title;
  final String initial;
  final String? hint;
  final int maxLines;

  @override
  State<_EditTextSheet> createState() => _EditTextSheetState();
}

class _EditTextSheetState extends State<_EditTextSheet> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initial,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AnjizSheetContent(
      title: widget.title,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnjizTextField(
              controller: _controller,
              autofocus: true,
              hintText: widget.hint,
              maxLines: widget.maxLines,
              minLines: widget.maxLines,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) => Navigator.of(context).pop(value),
            ),
            const SizedBox(height: AnjizSpacing.lg),
            AnjizButton(
              label: l10n.actionSave,
              icon: Icons.check_rounded,
              onPressed: () => Navigator.of(context).pop(_controller.text),
            ),
          ],
        ),
      ),
    );
  }
}

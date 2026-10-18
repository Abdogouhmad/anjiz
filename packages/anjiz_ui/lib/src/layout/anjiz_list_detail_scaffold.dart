import 'package:flutter/material.dart';

import 'anjiz_breakpoints.dart';

/// A list/detail shell that shows two panes side by side on wider screens and
/// falls back to a single pane on compact screens.
class AnjizListDetailScaffold extends StatelessWidget {
  /// Creates a list/detail scaffold.
  const AnjizListDetailScaffold({
    required this.listPane,
    this.detailPane,
    this.listFlex = 5,
    this.detailFlex = 7,
    super.key,
  });

  /// The master list pane.
  final Widget listPane;

  /// The detail pane. When null, only [listPane] is shown.
  final Widget? detailPane;

  /// Flex factor for the list pane.
  final int listFlex;

  /// Flex factor for the detail pane.
  final int detailFlex;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (!AnjizBreakpoints.isTwoPane(width) || detailPane == null) {
      return listPane;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: listFlex, child: listPane),
        const VerticalDivider(width: 1),
        Expanded(flex: detailFlex, child: detailPane!),
      ],
    );
  }
}

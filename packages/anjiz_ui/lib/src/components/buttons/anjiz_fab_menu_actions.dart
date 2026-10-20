import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';
import 'anjiz_fab_action_pill.dart';
import 'anjiz_fab_menu.dart';

/// The revealed action pills above an [AnjizFabMenu] toggle.
///
/// Internal building block of `AnjizFabMenu`; not exported from the barrel.
class AnjizFabMenuActions extends StatelessWidget {
  /// Creates the action list for the FAB menu.
  const AnjizFabMenuActions({
    required this.actions,
    required this.expansion,
    required this.onActionPressed,
    super.key,
  });

  /// Revealed secondary actions.
  final List<AnjizFabAction> actions;

  /// Drives the expansion/reveal of the actions.
  final Animation<double> expansion;

  /// Called when an action pill is pressed.
  final ValueChanged<AnjizFabAction> onActionPressed;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: expansion,
      alignment: AlignmentDirectional.bottomEnd,
      child: FadeTransition(
        opacity: expansion,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final action in actions)
              Padding(
                padding: const EdgeInsets.only(bottom: AnjizSpacing.sm),
                child: AnjizFabActionPill(
                  action: action,
                  onPressed: () => onActionPressed(action),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

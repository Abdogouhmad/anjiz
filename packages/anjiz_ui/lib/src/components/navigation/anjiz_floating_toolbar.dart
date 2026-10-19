import 'package:flutter/material.dart';

import '../../services/anjiz_haptics.dart';
import '../../tokens/anjiz_elevation.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// An icon action for [AnjizFloatingToolbar].
typedef AnjizToolbarAction = ({
  IconData icon,
  String tooltip,
  VoidCallback? onPressed,
});

/// A detached floating toolbar: an elevated pill holding an optional primary
/// action plus a row of icon actions.
class AnjizFloatingToolbar extends StatelessWidget {
  /// Creates a floating toolbar.
  const AnjizFloatingToolbar({
    this.primaryLabel,
    this.primaryIcon,
    this.onPrimaryPressed,
    this.actions = const <AnjizToolbarAction>[],
    super.key,
  });

  /// Optional primary action label.
  final String? primaryLabel;

  /// Optional primary action icon.
  final IconData? primaryIcon;

  /// Primary action handler.
  final VoidCallback? onPrimaryPressed;

  /// Secondary icon actions.
  final List<AnjizToolbarAction> actions;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(AnjizSpacing.xs + 2),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: AnjizShapes.pill,
        boxShadow: AnjizElevation.floating(scheme.onSurface),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (primaryLabel != null)
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: AnjizShapes.pill,
              ),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: onPrimaryPressed == null
                      ? null
                      : () {
                          AnjizHaptics.tap();
                          onPrimaryPressed!();
                        },
                  borderRadius: AnjizShapes.pill,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AnjizSpacing.md,
                    ),
                    child: Row(
                      children: [
                        if (primaryIcon != null) ...[
                          Icon(primaryIcon, size: 20, color: scheme.onPrimary),
                          const SizedBox(width: AnjizSpacing.sm),
                        ],
                        Text(
                          primaryLabel!,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: scheme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          for (final action in actions)
            IconButton(
              onPressed: action.onPressed == null
                  ? null
                  : () {
                      AnjizHaptics.tap();
                      action.onPressed!();
                    },
              tooltip: action.tooltip,
              icon: Icon(action.icon, color: scheme.onSurfaceVariant),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// Wraps a row so it can be swiped start-to-end to complete and
/// end-to-start to delete, mirroring Android task-list habits.
class AnjizSwipeRow extends StatelessWidget {
  /// Creates a swipeable row.
  const AnjizSwipeRow({
    required this.dismissKey,
    required this.child,
    this.onComplete,
    this.onDelete,
    super.key,
  });

  /// Stable key required by the underlying [Dismissible].
  final Key dismissKey;

  /// Row content.
  final Widget child;

  /// Invoked on a start-to-end swipe.
  final VoidCallback? onComplete;

  /// Invoked on an end-to-start swipe.
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Dismissible(
      key: dismissKey,
      background: _SwipeBackground(
        alignment: AlignmentDirectional.centerStart,
        color: scheme.primaryContainer,
        icon: Icons.check_circle_outline,
        iconColor: scheme.onPrimaryContainer,
      ),
      secondaryBackground: onDelete == null
          ? null
          : _SwipeBackground(
              alignment: AlignmentDirectional.centerEnd,
              color: scheme.errorContainer,
              icon: Icons.delete_outline,
              iconColor: scheme.onErrorContainer,
            ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onComplete?.call();
          return false;
        }
        onDelete?.call();
        return false;
      },
      child: child,
    );
  }
}

class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground({
    required this.alignment,
    required this.color,
    required this.icon,
    required this.iconColor,
  });

  final AlignmentGeometry alignment;
  final Color color;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      decoration: BoxDecoration(color: color, borderRadius: AnjizShapes.card),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AnjizSpacing.lg,
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}

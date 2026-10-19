import 'package:flutter/material.dart';

import '../../services/anjiz_haptics.dart';
import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import 'anjiz_drag_handle.dart';

/// Content scaffold for a modal bottom sheet, including the drag handle and
/// optional title.
class AnjizSheetContent extends StatelessWidget {
  /// Creates sheet content.
  const AnjizSheetContent({
    required this.child,
    this.title,
    this.showHandle = true,
    this.padding = const EdgeInsetsDirectional.fromSTEB(
      AnjizSpacing.lg,
      AnjizSpacing.sm,
      AnjizSpacing.lg,
      AnjizSpacing.lg,
    ),
    super.key,
  });

  /// Sheet content.
  final Widget child;

  /// Optional sheet title.
  final String? title;

  /// Whether to render the drag handle.
  final bool showHandle;

  /// Content padding.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showHandle) ...[
            const AnjizDragHandle(),
            const SizedBox(height: AnjizSpacing.md),
          ],
          if (title != null) ...[
            Text(title!, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AnjizSpacing.md),
          ],
          child,
        ],
      ),
    );
  }
}

/// Helpers for presenting Anjiz modal bottom sheets.
abstract final class AnjizBottomSheet {
  /// Shows a modal sheet hosting [child], respecting safe areas.
  ///
  /// Confirming the sheet (a non-null result) fires selection feedback.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AnjizShapes.extraLarge),
        ),
      ),
      builder: (context) => SafeArea(top: false, child: child),
    ).then((result) {
      if (result != null) AnjizHaptics.selection();
      return result;
    });
  }
}

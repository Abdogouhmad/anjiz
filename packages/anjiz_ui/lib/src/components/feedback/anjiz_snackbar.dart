import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';

/// Presents Anjiz-styled floating snack bars (used for undo and confirmations).
abstract final class AnjizSnackBar {
  /// Shows a snack bar with an optional single action.
  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
  }) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
          action: actionLabel == null
              ? null
              : SnackBarAction(
                  label: actionLabel,
                  onPressed: onAction ?? () {},
                ),
          shape: const RoundedRectangleBorder(borderRadius: AnjizShapes.nested),
        ),
      );
  }
}

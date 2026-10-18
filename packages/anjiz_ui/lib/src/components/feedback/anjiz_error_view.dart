import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';

/// A centered error state with an optional retry action.
class AnjizErrorView extends StatelessWidget {
  /// Creates an error view.
  const AnjizErrorView({
    required this.title,
    this.message,
    this.onRetry,
    this.retryLabel,
    super.key,
  });

  /// Short error headline.
  final String title;

  /// Optional error detail.
  final String? message;

  /// Retry callback. When null, no retry button is shown.
  final VoidCallback? onRetry;

  /// Localised retry label.
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(AnjizSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded, size: 48, color: scheme.error),
          const SizedBox(height: AnjizSpacing.md),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.titleMedium,
          ),
          if (message != null) ...[
            const SizedBox(height: AnjizSpacing.sm),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
          if (onRetry != null && retryLabel != null) ...[
            const SizedBox(height: AnjizSpacing.lg),
            FilledButton.tonal(onPressed: onRetry, child: Text(retryLabel!)),
          ],
        ],
      ),
    );
  }
}

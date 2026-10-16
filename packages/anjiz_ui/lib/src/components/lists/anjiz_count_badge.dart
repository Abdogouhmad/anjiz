import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// A compact numeric/`n` counter badge (e.g. section counts, "3 tasks").
class AnjizCountBadge extends StatelessWidget {
  /// Creates a count badge.
  const AnjizCountBadge({
    required this.label,
    this.background,
    this.foreground,
    super.key,
  });

  /// Text shown inside the badge (already localised).
  final String label;

  /// Optional background override.
  final Color? background;

  /// Optional foreground override.
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AnjizSpacing.sm + 2,
        vertical: AnjizSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: background ?? scheme.surfaceContainer,
        borderRadius: AnjizShapes.pill,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge
            ?.copyWith(color: foreground ?? scheme.onSurfaceVariant, height: 1),
      ),
    );
  }
}

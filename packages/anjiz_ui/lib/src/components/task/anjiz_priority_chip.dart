import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// A honey-tinted chip expressing a task's priority level.
class AnjizPriorityChip extends StatelessWidget {
  /// Creates a priority chip.
  const AnjizPriorityChip({
    required this.label,
    this.icon = Icons.star_rounded,
    this.onTap,
    super.key,
  });

  /// Localised priority label (e.g. "High").
  final String label;

  /// Leading icon.
  final IconData icon;

  /// Optional tap handler.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final content = Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AnjizSpacing.sm + 2,
        vertical: AnjizSpacing.xs + 1,
      ),
      decoration: BoxDecoration(
        color: scheme.tertiaryFixed,
        borderRadius: AnjizShapes.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: scheme.onTertiaryFixed),
          const SizedBox(width: AnjizSpacing.xs + 1),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: scheme.onTertiaryFixed, height: 1.2),
          ),
        ],
      ),
    );
    if (onTap == null) return content;
    return InkWell(
      onTap: onTap,
      borderRadius: AnjizShapes.pill,
      child: content,
    );
  }
}

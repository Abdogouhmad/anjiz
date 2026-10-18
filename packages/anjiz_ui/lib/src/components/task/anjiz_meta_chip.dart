import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import '../common/anjiz_tone.dart';

/// A small icon+label pill for task metadata (time, list, tags, location…).
class AnjizMetaChip extends StatelessWidget {
  /// Creates a metadata chip.
  const AnjizMetaChip({
    required this.label,
    this.icon,
    this.tone = AnjizTone.neutral,
    this.onTap,
    super.key,
  });

  /// Localised label text.
  final String label;

  /// Optional leading icon.
  final IconData? icon;

  /// Semantic tone driving the colours.
  final AnjizTone tone;

  /// Optional tap handler (turns the chip into a control).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = tone.resolve(scheme);
    final content = Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AnjizSpacing.sm + 2,
        vertical: AnjizSpacing.xs + 1,
      ),
      decoration: BoxDecoration(
        color: colors.container,
        borderRadius: AnjizShapes.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 15, color: colors.onContainer),
            const SizedBox(width: AnjizSpacing.xs + 1),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: colors.onContainer, height: 1.2),
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

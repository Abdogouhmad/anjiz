import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import '../common/anjiz_tone.dart';

/// A small text pill used for labels such as "Material You", "8:00 AM" or
/// "Delight". Optionally leading-iconed and tonally coloured.
class AnjizTagPill extends StatelessWidget {
  /// Creates a tag pill.
  const AnjizTagPill({
    required this.label,
    this.tone = AnjizTone.neutral,
    this.icon,
    this.compact = false,
    super.key,
  });

  /// Localised label text.
  final String label;

  /// Semantic tone driving the colours.
  final AnjizTone tone;

  /// Optional leading icon.
  final IconData? icon;

  /// Tightens padding for dense rows.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = tone.resolve(scheme);
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: compact ? AnjizSpacing.sm : AnjizSpacing.sm + 2,
        vertical: AnjizSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.container,
        borderRadius: AnjizShapes.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: colors.onContainer),
            const SizedBox(width: AnjizSpacing.xs),
          ],
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              color: colors.onContainer,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

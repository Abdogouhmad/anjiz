import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';
import '../common/anjiz_tone.dart';
import '../lists/anjiz_tag_pill.dart';

/// A titled slider row with an optional value badge and a set of tick labels.
class AnjizSliderTile extends StatelessWidget {
  /// Creates a slider tile.
  const AnjizSliderTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.min = 0,
    this.max = 1,
    this.divisions,
    this.valueLabel,
    this.labels = const <String>[],
    this.leadingIcon,
    this.trailingIcon,
    super.key,
  });

  /// Primary label.
  final String title;

  /// Optional supporting copy.
  final String? subtitle;

  /// Current value.
  final double value;

  /// Change handler.
  final ValueChanged<double>? onChanged;

  /// Minimum value.
  final double min;

  /// Maximum value.
  final double max;

  /// Number of discrete stops.
  final int? divisions;

  /// Optional badge showing the current value label.
  final String? valueLabel;

  /// Optional evenly-spaced labels rendered below the track.
  final List<String> labels;

  /// Optional leading icon beside the track.
  final IconData? leadingIcon;

  /// Optional trailing icon beside the track.
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.titleSmall),
                  if (subtitle != null) ...[
                    const SizedBox(height: AnjizSpacing.xs),
                    Text(
                      subtitle!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (valueLabel != null)
              AnjizTagPill(label: valueLabel!, tone: AnjizTone.primary),
          ],
        ),
        Row(
          children: [
            if (leadingIcon != null)
              Icon(leadingIcon, size: 18, color: scheme.onSurfaceVariant),
            Expanded(
              child: Slider(
                value: value.clamp(min, max),
                min: min,
                max: max,
                divisions: divisions,
                onChanged: onChanged,
              ),
            ),
            if (trailingIcon != null)
              Icon(trailingIcon, size: 22, color: scheme.primary),
          ],
        ),
        if (labels.isNotEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AnjizSpacing.xl,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final label in labels)
                  Text(
                    label,
                    style: textTheme.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

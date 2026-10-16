import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// A selectable accent colour: an ARGB value with a localised label.
typedef AnjizSwatch = ({int color, String label});

/// A horizontal row of accent-colour swatches with a selected indicator.
class AnjizColorSwatches extends StatelessWidget {
  /// Creates a colour swatch row.
  const AnjizColorSwatches({
    required this.swatches,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  /// Available swatches.
  final List<AnjizSwatch> swatches;

  /// Index of the currently selected swatch.
  final int selectedIndex;

  /// Called with the chosen swatch index.
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Changed from spaceBetween
        children: [
          for (var i = 0; i < swatches.length; i++)
            // Use SizedBox with fixed width for each swatch
            SizedBox(
              width: 64, // Adjust this value as needed
              child: _SwatchButton(
                swatch: swatches[i],
                selected: i == selectedIndex,
                onTap: () => onSelected(i),
              ),
            ),
        ],
      ),
    );
  }
}

class _SwatchButton extends StatelessWidget {
  const _SwatchButton({
    required this.swatch,
    required this.selected,
    required this.onTap,
  });

  final AnjizSwatch swatch;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = Color(swatch.color);
    return Semantics(
      selected: selected,
      button: true,
      label: swatch.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: AnjizShapes.pill,
        child: Padding(
          padding: const EdgeInsets.all(AnjizSpacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 44,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? scheme.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: selected
                      ? Icon(Icons.check, size: 20, color: scheme.onPrimary)
                      : null,
                ),
              ),
              const SizedBox(height: AnjizSpacing.xs + 2),
              Text(
                swatch.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

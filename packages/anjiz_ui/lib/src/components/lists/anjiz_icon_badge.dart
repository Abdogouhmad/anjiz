import 'package:flutter/material.dart';

import '../common/anjiz_tone.dart';

/// A circular tonal badge hosting an icon — used for section headers, list
/// leading slots and settings cards.
class AnjizIconBadge extends StatelessWidget {
  /// Creates an icon badge.
  const AnjizIconBadge({
    required this.icon,
    this.tone = AnjizTone.secondary,
    this.size = 40,
    this.iconSize = 20,
    this.iconColor,
    super.key,
  });

  /// Icon rendered inside the badge.
  final IconData icon;

  /// Semantic tone driving the fill.
  final AnjizTone tone;

  /// Diameter of the badge.
  final double size;

  /// Size of the icon.
  final double iconSize;

  /// Optional explicit icon colour, overriding the tone.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = tone.resolve(scheme);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.container,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: iconSize, color: iconColor ?? colors.onContainer),
    );
  }
}

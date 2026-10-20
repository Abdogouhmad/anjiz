import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// The 4dp accent bar at the start edge of an [AnjizTaskTile].
///
/// Internal building block; not exported from the package barrel.
class AnjizTaskAccentBar extends StatelessWidget {
  /// Creates the accent bar.
  const AnjizTaskAccentBar({required this.color, super.key});

  /// Bar colour (priority or overdue tone).
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AnjizSpacing.xs),
      child: Container(
        width: 4,
        height: 44,
        decoration: BoxDecoration(color: color, borderRadius: AnjizShapes.pill),
      ),
    );
  }
}

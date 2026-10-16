import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';

/// The canonical Anjiz drag handle: a 32x4 pill centered above sheet content.
class AnjizDragHandle extends StatelessWidget {
  /// Creates a drag handle.
  const AnjizDragHandle({this.width = 32, super.key});

  /// Width of the handle.
  final double width;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        width: width,
        height: 4,
        decoration: BoxDecoration(
          color: scheme.outlineVariant,
          borderRadius: AnjizShapes.pill,
        ),
      ),
    );
  }
}

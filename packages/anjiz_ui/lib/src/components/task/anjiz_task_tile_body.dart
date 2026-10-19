import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';

/// The text block of an [AnjizTaskTile]: title, optional subtitle and meta
/// chips.
///
/// Internal building block of `AnjizTaskTile`; not exported from the barrel.
class AnjizTaskTileBody extends StatelessWidget {
  /// Creates the tile body.
  const AnjizTaskTileBody({
    required this.title,
    required this.isDone,
    this.strikethroughOnDone = true,
    this.subtitle,
    this.meta = const <Widget>[],
    super.key,
  });

  /// Task title.
  final String title;

  /// Whether the task is complete.
  final bool isDone;

  /// Whether to strike through the title once complete.
  final bool strikethroughOnDone;

  /// Optional secondary line below the title.
  final Widget? subtitle;

  /// Metadata chips shown beneath the title.
  final List<Widget> meta;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleMedium!.copyWith(
      color: isDone ? scheme.onSurfaceVariant : scheme.onSurface,
      decoration: isDone && strikethroughOnDone
          ? TextDecoration.lineThrough
          : TextDecoration.none,
      decorationColor: scheme.onSurfaceVariant,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        if (subtitle != null) ...[
          const SizedBox(height: AnjizSpacing.xs),
          DefaultTextStyle.merge(
            style: textTheme.bodyMedium!.copyWith(
              color: scheme.onSurfaceVariant,
            ),
            child: subtitle!,
          ),
        ],
        if (meta.isNotEmpty) ...[
          const SizedBox(height: AnjizSpacing.sm),
          Wrap(
            spacing: AnjizSpacing.sm,
            runSpacing: AnjizSpacing.sm,
            children: meta,
          ),
        ],
      ],
    );
  }
}

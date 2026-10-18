import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';

/// A large, collapsing top app bar sliver with an optional display title,
/// small subtitle and trailing actions — the expressive Anjiz header.
class AnjizLargeAppBar extends StatelessWidget {
  /// Creates a large collapsing app bar.
  const AnjizLargeAppBar({
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.pinned = true,
    this.expandedHeight = 132,
    super.key,
  });

  /// Big display title.
  final String title;

  /// Optional small subtitle under the title.
  final String? subtitle;

  /// Optional leading widget.
  final Widget? leading;

  /// Trailing action widgets.
  final List<Widget>? actions;

  /// Whether the collapsed bar stays pinned.
  final bool pinned;

  /// Height of the expanded bar.
  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SliverAppBar(
      pinned: pinned,
      expandedHeight: expandedHeight,
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      leading: leading,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsetsDirectional.only(
          start: AnjizSpacing.md,
          end: AnjizSpacing.md,
          bottom: AnjizSpacing.md,
        ),
        // The flexible space is only ~49dp tall once collapsed — less than the
        // natural height of the title + subtitle stack (and much less at large
        // text scales), so the whole stack scales down to fit rather than
        // overflowing.
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.bottomStart,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineMedium?.copyWith(
                  color: scheme.onSurface,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';
import 'anjiz_count_badge.dart';

/// A grouped-list section header: an optional status dot, a title, an optional
/// count badge and a trailing action.
class AnjizSectionHeader extends StatelessWidget {
  /// Creates a section header.
  const AnjizSectionHeader({
    required this.title,
    this.count,
    this.trailing,
    this.dotColor,
    super.key,
  });

  /// Section title.
  final String title;

  /// Optional localised count label (e.g. "3 tasks").
  final String? count;

  /// Optional trailing widget (e.g. an action or a small label).
  final Widget? trailing;

  /// Optional leading status dot colour.
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: AnjizSpacing.sm),
      child: Row(
        children: [
          if (dotColor != null) ...[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AnjizSpacing.sm),
          ],
          Flexible(
            child: Text(
              title,
              style: textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: AnjizSpacing.sm),
            AnjizCountBadge(label: count!),
          ],
          const SizedBox(width: AnjizSpacing.md),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

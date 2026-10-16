import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';

/// A centered empty/celebration state: an optional illustration, a title,
/// supporting copy and a column of actions.
class AnjizEmptyState extends StatelessWidget {
  /// Creates an empty state.
  const AnjizEmptyState({
    required this.title,
    this.message,
    this.illustration,
    this.icon,
    this.actions = const <Widget>[],
    this.compact = false,
    super.key,
  });

  /// Headline text.
  final String title;

  /// Optional supporting copy.
  final String? message;

  /// Optional custom illustration widget.
  final Widget? illustration;

  /// Optional icon shown when no [illustration] is supplied.
  final IconData? icon;

  /// Call-to-action widgets rendered below the copy.
  final List<Widget> actions;

  /// Tightens vertical spacing for inline use.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final gap = compact ? AnjizSpacing.md : AnjizSpacing.lg;
    return Padding(
      padding: const EdgeInsets.all(AnjizSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (illustration != null)
            illustration!
          else if (icon != null)
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: scheme.onSecondaryContainer),
            ),
          SizedBox(height: gap),
          Text(
            title,
            textAlign: TextAlign.center,
            style: (compact ? textTheme.titleLarge : textTheme.headlineMedium),
          ),
          if (message != null) ...[
            const SizedBox(height: AnjizSpacing.sm),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
          if (actions.isNotEmpty) ...[
            SizedBox(height: gap),
            Column(
              children: [
                for (final action in actions)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AnjizSpacing.sm),
                    child: SizedBox(width: double.infinity, child: action),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

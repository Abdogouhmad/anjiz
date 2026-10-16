import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';
import '../common/anjiz_tone.dart';
import '../lists/anjiz_card.dart';
import '../lists/anjiz_icon_badge.dart';

/// A grouped settings card with a vertical stack of children (switch tiles,
/// nav tiles, sliders…) and an optional icon-badge header.
///
/// Omit [icon] and [title] to render a header-less group — the shape used on
/// screens where an [AnjizSectionHeader] above the card already names it.
class AnjizSettingsCard extends StatelessWidget {
  /// Creates a settings card.
  const AnjizSettingsCard({
    required this.children,
    this.icon,
    this.title,
    this.trailing,
    this.headerTone = AnjizTone.secondary,
    super.key,
  });

  /// Card body.
  final List<Widget> children;

  /// Header icon. Set together with [title].
  final IconData? icon;

  /// Header title. Set together with [icon].
  final String? title;

  /// Optional header trailing widget (e.g. a tag pill).
  final Widget? trailing;

  /// Tone for the header icon badge.
  final AnjizTone headerTone;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final icon = this.icon;
    final title = this.title;
    final hasHeader = icon != null && title != null;
    return AnjizCard(
      padding: const EdgeInsets.all(AnjizSpacing.md20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hasHeader) ...[
            Row(
              children: [
                AnjizIconBadge(
                  icon: icon,
                  tone: headerTone,
                  size: 36,
                  iconSize: 18,
                ),
                const SizedBox(width: AnjizSpacing.md12),
                Expanded(child: Text(title, style: textTheme.titleMedium)),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: AnjizSpacing.lg),
          ],
          for (var i = 0; i < children.length; i++) ...[
            if (i != 0) const SizedBox(height: AnjizSpacing.lg),
            children[i],
          ],
        ],
      ),
    );
  }
}

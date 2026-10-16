import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';
import '../common/anjiz_tone.dart';
import '../lists/anjiz_card.dart';
import '../lists/anjiz_icon_badge.dart';

/// A grouped settings card with a leading icon badge, a title and a vertical
/// stack of children (switch tiles, nav tiles, sliders…).
class AnjizSettingsCard extends StatelessWidget {
  /// Creates a settings card.
  const AnjizSettingsCard({
    required this.icon,
    required this.title,
    required this.children,
    this.trailing,
    this.headerTone = AnjizTone.secondary,
    super.key,
  });

  /// Header icon.
  final IconData icon;

  /// Header title.
  final String title;

  /// Card body.
  final List<Widget> children;

  /// Optional header trailing widget (e.g. a tag pill).
  final Widget? trailing;

  /// Tone for the header icon badge.
  final AnjizTone headerTone;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AnjizCard(
      padding: const EdgeInsets.all(AnjizSpacing.md20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          for (var i = 0; i < children.length; i++) ...[
            if (i != 0) const SizedBox(height: AnjizSpacing.lg),
            children[i],
          ],
        ],
      ),
    );
  }
}

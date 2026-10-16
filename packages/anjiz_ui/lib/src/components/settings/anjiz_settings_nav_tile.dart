import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';
import '../lists/anjiz_list_tile.dart';

/// A tappable settings row with a leading icon, title, subtitle and a trailing
/// chevron, resting on the lower tonal step.
class AnjizSettingsNavTile extends StatelessWidget {
  /// Creates a settings navigation row.
  const AnjizSettingsNavTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  /// Primary label.
  final String title;

  /// Optional supporting copy.
  final String? subtitle;

  /// Optional leading widget.
  final Widget? leading;

  /// Optional trailing widget. Defaults to a directional chevron.
  final Widget? trailing;

  /// Tap handler.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AnjizShapes.large),
      ),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AnjizSpacing.md12,
        vertical: AnjizSpacing.sm,
      ),
      child: AnjizListTile(
        leading: leading,
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        onTap: onTap,
        trailing:
            trailing ??
            Icon(Icons.chevron_right_rounded, color: scheme.onSurfaceVariant),
      ),
    );
  }
}

/// Radius token reused by settings rows.
const BorderRadius anjizSettingsTileRadius = BorderRadius.all(
  Radius.circular(AnjizShapes.large),
);

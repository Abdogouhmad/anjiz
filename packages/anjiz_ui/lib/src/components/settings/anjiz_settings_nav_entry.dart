import 'package:flutter/material.dart';

import '../common/anjiz_tone.dart';

/// One row in a settings navigation group: a leading icon badge, a title,
/// optional supporting copy and a tap handler that opens a nested screen.
class AnjizSettingsNavEntry {
  /// Creates a navigation entry.
  const AnjizSettingsNavEntry({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.tone = AnjizTone.primary,
    this.trailing,
  });

  /// Icon shown in the row's leading badge.
  final IconData icon;

  /// Primary label.
  final String title;

  /// Called when the row is tapped.
  final VoidCallback onTap;

  /// Optional supporting copy describing what the row opens.
  final String? subtitle;

  /// Tone of the leading icon badge.
  final AnjizTone tone;

  /// Optional trailing widget. Defaults to a directional chevron.
  final Widget? trailing;
}

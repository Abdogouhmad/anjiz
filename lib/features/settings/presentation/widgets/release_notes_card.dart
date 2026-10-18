import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

/// The published release notes for an available update, rendered as Markdown in
/// a tonal card.
///
/// The notes come from `CHANGELOG.md` via `update_manifest.json`, so they are
/// already written for users.
class ReleaseNotesCard extends StatelessWidget {
  /// Creates a release-notes card.
  const ReleaseNotesCard({required this.notes, super.key});

  /// Markdown source, as published in the manifest.
  final String notes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final style = MarkdownStyleSheet.fromTheme(theme).copyWith(
      p: text.bodyMedium,
      listBullet: text.bodyMedium,
      strong: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      h1: text.titleMedium,
      h2: text.titleMedium,
      h3: text.titleSmall,
      blockSpacing: AnjizSpacing.sm,
      h1Padding: EdgeInsets.zero,
      h2Padding: const EdgeInsets.only(top: AnjizSpacing.sm),
      h3Padding: const EdgeInsets.only(top: AnjizSpacing.sm),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
    );
    return AnjizCard(
      padding: const EdgeInsets.all(AnjizSpacing.md20),
      child: MarkdownBody(data: notes, styleSheet: style),
    );
  }
}

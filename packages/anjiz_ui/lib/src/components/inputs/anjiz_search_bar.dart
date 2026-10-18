import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// A full-pill search bar. Renders a tappable bar when [readOnly] is true and
/// a live field otherwise.
class AnjizSearchBar extends StatelessWidget {
  /// Creates a search bar.
  const AnjizSearchBar({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.readOnly = false,
    this.autofocus = false,
    this.trailing,
    super.key,
  });

  /// Placeholder text.
  final String hintText;

  /// Field controller.
  final TextEditingController? controller;

  /// Change handler.
  final ValueChanged<String>? onChanged;

  /// Tap handler (used when [readOnly] is true).
  final VoidCallback? onTap;

  /// Submit handler.
  final ValueChanged<String>? onSubmitted;

  /// Renders a read-only tap target instead of an editable field.
  final bool readOnly;

  /// Whether to focus on mount.
  final bool autofocus;

  /// Trailing widget.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final field = TextField(
      controller: controller,
      readOnly: readOnly,
      autofocus: autofocus,
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search_rounded, color: scheme.onSurfaceVariant),
        suffixIcon: trailing,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: AnjizShapes.input,
      ),
      child: field,
    );
  }
}

/// Padding constant exported for feature-level layout parity.
const EdgeInsetsGeometry anjizSearchBarPadding =
    EdgeInsetsDirectional.symmetric(horizontal: AnjizSpacing.md);

import 'package:flutter/material.dart';

import '../../tokens/anjiz_shapes.dart';
import '../../tokens/anjiz_spacing.dart';

/// A pill-shaped text field with no external outline, matching the Anjiz
/// expressive input style.
class AnjizTextField extends StatelessWidget {
  /// Creates a text field.
  const AnjizTextField({
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffix,
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.sentences,
    super.key,
  });

  /// Field controller.
  final TextEditingController? controller;

  /// Placeholder text.
  final String? hintText;

  /// Optional label above the field.
  final String? labelText;

  /// Leading icon.
  final IconData? prefixIcon;

  /// Trailing widget.
  final Widget? suffix;

  /// Change handler.
  final ValueChanged<String>? onChanged;

  /// Submit handler.
  final ValueChanged<String>? onSubmitted;

  /// Whether to focus on mount.
  final bool autofocus;

  /// Maximum lines.
  final int maxLines;

  /// Minimum lines.
  final int? minLines;

  /// Keyboard action button.
  final TextInputAction? textInputAction;

  /// Capitalisation behaviour.
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: textTheme.labelMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AnjizSpacing.sm),
        ],
        TextField(
          controller: controller,
          autofocus: autofocus,
          maxLines: maxLines,
          minLines: minLines,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}

/// A leading icon shared by input decorations.
class AnjizInputIcon extends StatelessWidget {
  /// Creates an input leading icon.
  const AnjizInputIcon(this.icon, {super.key});

  /// Icon to render.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: AnjizSpacing.md),
      child: Icon(icon, color: scheme.onSurfaceVariant),
    );
  }
}

/// Convenience padding used by search/task input pills.
const EdgeInsetsGeometry anjizInputPadding = EdgeInsetsDirectional.symmetric(
  horizontal: AnjizSpacing.md,
  vertical: AnjizSpacing.md12,
);

/// Radius used by all Anjiz inputs.
const BorderRadius anjizInputRadius = AnjizShapes.input;

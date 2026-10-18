import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';

/// Visual variants for [AnjizButton].
enum AnjizButtonVariant {
  /// High-emphasis filled button.
  filled,

  /// Sage tonal button.
  tonal,

  /// Outlined button.
  outlined,

  /// Low-emphasis text button.
  text,
}

/// Size variants for [AnjizButton].
enum AnjizButtonSize {
  /// 40dp tall.
  small,

  /// 48dp tall (default, meets minimum touch target).
  medium,

  /// 56dp tall.
  large,
}

/// The Anjiz pill button with optional leading icon, variants and sizes.
class AnjizButton extends StatelessWidget {
  /// Creates a button.
  const AnjizButton({
    required this.label,
    this.onPressed,
    this.variant = AnjizButtonVariant.filled,
    this.size = AnjizButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.expand = false,
    this.loading = false,
    super.key,
  });

  /// Button label.
  final String label;

  /// Tap handler. When null the button renders disabled.
  final VoidCallback? onPressed;

  /// Visual variant.
  final AnjizButtonVariant variant;

  /// Size variant.
  final AnjizButtonSize size;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional trailing icon.
  final IconData? trailingIcon;

  /// Whether the button should fill the available width.
  final bool expand;

  /// Shows a spinner and disables interaction.
  final bool loading;

  double get _height => switch (size) {
    AnjizButtonSize.small => 40,
    AnjizButtonSize.medium => 48,
    AnjizButtonSize.large => 56,
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final style = _style(scheme, textTheme);
    final effective = loading ? null : onPressed;
    // Resolve the foreground for the *current* state so the label matches the
    // icon. A bare `textTheme` style would carry the theme's default onSurface
    // colour, which is unreadable on filled/tonal container backgrounds.
    final foreground = style.foregroundColor?.resolve(
      effective == null
          ? const <WidgetState>{WidgetState.disabled}
          : const <WidgetState>{},
    );
    final labelStyle = textTheme.labelLarge?.copyWith(color: foreground);

    final child = loading
        ? SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: foreground),
          )
        : Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: AnjizSpacing.sm),
              ],
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: labelStyle,
                ),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: AnjizSpacing.sm),
                Icon(trailingIcon, size: 20),
              ],
            ],
          );

    final sized = SizedBox(height: _height, child: child);
    final padded = expand
        ? SizedBox(width: double.infinity, child: sized)
        : sized;

    return switch (variant) {
      AnjizButtonVariant.filled => FilledButton(
        onPressed: effective,
        style: style,
        child: padded,
      ),
      AnjizButtonVariant.tonal => FilledButton(
        onPressed: effective,
        style: style,
        child: padded,
      ),
      AnjizButtonVariant.outlined => OutlinedButton(
        onPressed: effective,
        style: style,
        child: padded,
      ),
      AnjizButtonVariant.text => TextButton(
        onPressed: effective,
        style: style,
        child: padded,
      ),
    };
  }

  ButtonStyle _style(ColorScheme scheme, TextTheme textTheme) {
    final padding = EdgeInsetsDirectional.symmetric(
      horizontal: size == AnjizButtonSize.small
          ? AnjizSpacing.md
          : AnjizSpacing.lg,
    );
    final base = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(0, _height)),
      padding: WidgetStatePropertyAll(padding),
      textStyle: WidgetStatePropertyAll(textTheme.labelLarge),
      shape: const WidgetStatePropertyAll(StadiumBorder()),
    );
    return switch (variant) {
      AnjizButtonVariant.filled => base.copyWith(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? scheme.onSurface.withValues(alpha: 0.12)
              : scheme.primary,
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? scheme.onSurface.withValues(alpha: 0.38)
              : scheme.onPrimary,
        ),
      ),
      AnjizButtonVariant.tonal => base.copyWith(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? scheme.onSurface.withValues(alpha: 0.12)
              : scheme.secondaryContainer,
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? scheme.onSurface.withValues(alpha: 0.38)
              : scheme.onSecondaryContainer,
        ),
      ),
      AnjizButtonVariant.outlined => base.copyWith(
        side: WidgetStatePropertyAll(BorderSide(color: scheme.outlineVariant)),
        foregroundColor: WidgetStatePropertyAll(scheme.primary),
      ),
      AnjizButtonVariant.text => base.copyWith(
        foregroundColor: WidgetStatePropertyAll(scheme.primary),
      ),
    };
  }
}

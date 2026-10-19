import 'package:flutter/material.dart';

import '../../services/anjiz_haptics.dart';
import 'anjiz_button_content.dart';
import 'anjiz_button_style.dart';

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

/// Height in logical pixels for each [AnjizButtonSize].
extension AnjizButtonSizeHeight on AnjizButtonSize {
  /// Height in logical pixels.
  double get buttonHeight => switch (this) {
    AnjizButtonSize.small => 40,
    AnjizButtonSize.medium => 48,
    AnjizButtonSize.large => 56,
  };
}

/// The Anjiz pill button with optional leading icon, variants and sizes.
///
/// Pressing the button fires light haptic feedback (see [AnjizHaptics]).
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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = anjizButtonStyle(
      variant: variant,
      size: size,
      scheme: scheme,
      textTheme: Theme.of(context).textTheme,
    );
    final effective = loading ? null : onPressed;
    final sized = SizedBox(
      height: size.buttonHeight,
      child: AnjizButtonContent(
        label: label,
        loading: loading,
        expand: expand,
        style: style,
        icon: icon,
        trailingIcon: trailingIcon,
      ),
    );
    final padded = expand
        ? SizedBox(width: double.infinity, child: sized)
        : sized;
    final pressed = effective == null
        ? null
        : () {
            AnjizHaptics.tap();
            effective();
          };

    return switch (variant) {
      AnjizButtonVariant.filled => FilledButton(
        onPressed: pressed,
        style: style,
        child: padded,
      ),
      AnjizButtonVariant.tonal => FilledButton(
        onPressed: pressed,
        style: style,
        child: padded,
      ),
      AnjizButtonVariant.outlined => OutlinedButton(
        onPressed: pressed,
        style: style,
        child: padded,
      ),
      AnjizButtonVariant.text => TextButton(
        onPressed: pressed,
        style: style,
        child: padded,
      ),
    };
  }
}

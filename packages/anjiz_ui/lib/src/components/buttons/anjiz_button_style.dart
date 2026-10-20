import 'package:flutter/material.dart';

import '../../tokens/anjiz_spacing.dart';
import 'anjiz_button.dart';

/// Resolves the [ButtonStyle] for an [AnjizButton] variant and size.
///
/// Split from `anjiz_button.dart` so both files stay small.
ButtonStyle anjizButtonStyle({
  required AnjizButtonVariant variant,
  required AnjizButtonSize size,
  required ColorScheme scheme,
  required TextTheme textTheme,
}) {
  final height = size.buttonHeight;
  final padding = EdgeInsetsDirectional.symmetric(
    horizontal: size == AnjizButtonSize.small
        ? AnjizSpacing.md
        : AnjizSpacing.lg,
  );
  final base = ButtonStyle(
    minimumSize: WidgetStatePropertyAll(Size(0, height)),
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

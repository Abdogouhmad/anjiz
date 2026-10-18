import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

/// The animated page indicator under the onboarding pages.
class OnboardingDots extends StatelessWidget {
  /// Creates the page indicator.
  const OnboardingDots({required this.count, required this.index, super.key});

  /// Total number of pages.
  final int count;

  /// Currently visible page.
  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: AnjizMotion.fast,
            margin: const EdgeInsetsDirectional.symmetric(
              horizontal: AnjizSpacing.xs,
            ),
            width: i == index ? 28 : 10,
            height: 10,
            decoration: BoxDecoration(
              color: i == index
                  ? scheme.primary
                  : scheme.surfaceContainerHighest,
              borderRadius: AnjizShapes.pill,
            ),
          ),
      ],
    );
  }
}

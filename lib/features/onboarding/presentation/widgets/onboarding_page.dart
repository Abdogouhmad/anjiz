import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

/// One marketing page of the onboarding flow: badge, title and message.
class OnboardingPage extends StatelessWidget {
  /// Creates an onboarding page.
  const OnboardingPage({
    required this.icon,
    required this.title,
    required this.message,
    super.key,
  });

  /// Expressive badge icon.
  final IconData icon;

  /// Headline.
  final String title;

  /// Supporting copy.
  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnjizIconBadge(
          icon: icon,
          tone: AnjizTone.primary,
          size: 132,
          iconSize: 64,
        ),
        const SizedBox(height: AnjizSpacing.xl),
        Text(
          title,
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall,
        ),
        const SizedBox(height: AnjizSpacing.md12),
        Text(
          message,
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

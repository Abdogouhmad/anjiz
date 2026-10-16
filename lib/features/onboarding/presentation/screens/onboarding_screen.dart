import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/providers/settings_controller.dart';

/// The first-run onboarding flow: three expressive pages and a single action.
class OnboardingScreen extends ConsumerStatefulWidget {
  /// Creates the onboarding screen.
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<({IconData icon, String title, String message})> _pages(
    AppLocalizations l10n,
  ) => [
    (
      icon: Icons.done_all_rounded,
      title: l10n.onboardingTitle1,
      message: l10n.onboardingMessage1,
    ),
    (
      icon: Icons.auto_awesome_rounded,
      title: l10n.onboardingTitle2,
      message: l10n.onboardingMessage2,
    ),
    (
      icon: Icons.widgets_rounded,
      title: l10n.onboardingTitle3,
      message: l10n.onboardingMessage3,
    ),
  ];

  Future<void> _finish() async {
    await ref.read(settingsControllerProvider.notifier).completeOnboarding();
    if (mounted) context.go(AppRoutes.today);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pages = _pages(l10n);
    final isLast = _index == pages.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AnjizSpacing.lg),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: _finish,
                  child: Text(l10n.onboardingSkip),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) => setState(() => _index = index),
                  children: [
                    for (final page in pages)
                      _OnboardingPage(
                        icon: page.icon,
                        title: page.title,
                        message: page.message,
                      ),
                  ],
                ),
              ),
              _PageDots(count: pages.length, index: _index),
              const SizedBox(height: AnjizSpacing.lg),
              AnjizButton(
                label: isLast ? l10n.actionGetStarted : l10n.actionNext,
                icon: isLast ? Icons.rocket_launch_rounded : null,
                trailingIcon: isLast ? null : Icons.arrow_forward_rounded,
                expand: true,
                size: AnjizButtonSize.large,
                onPressed: () {
                  if (isLast) {
                    _finish();
                  } else {
                    _controller.nextPage(
                      duration: AnjizMotion.standard,
                      curve: AnjizMotion.standardCurve,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
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

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.index});

  final int count;
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

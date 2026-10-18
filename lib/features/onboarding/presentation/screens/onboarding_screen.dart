import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/providers/profile_controller.dart';
import '../../../settings/presentation/providers/settings_controller.dart';
import '../widgets/onboarding_dots.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/onboarding_permissions_page.dart';
import '../widgets/onboarding_profile_page.dart';

/// The first-run onboarding flow: three expressive pages, a profile step and
/// a permissions step, finished with a single action.
class OnboardingScreen extends ConsumerStatefulWidget {
  /// Creates the onboarding screen.
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  int _index = 0;

  /// Index of the profile step, so it can be swapped in and out.
  static const int _profileIndex = 3;

  @override
  void dispose() {
    _controller.dispose();
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  int get _pageCount => _profileIndex + 2;

  Future<void> _finish() async {
    await _saveProfile();
    await ref.read(settingsControllerProvider.notifier).completeOnboarding();
    if (mounted) context.go(AppRoutes.today);
  }

  /// Persists whatever was typed; the avatar is saved in place by the picker.
  Future<void> _saveProfile() async {
    await ref
        .read(profileProvider.notifier)
        .save(name: _name.text, email: _email.text);
  }

  void _goToPage(int index) {
    _controller.animateToPage(
      index,
      duration: AnjizMotion.standard,
      curve: AnjizMotion.standardCurve,
    );
  }

  Widget _page(int index, AppLocalizations l10n) => switch (index) {
    0 => OnboardingPage(
      icon: Icons.done_all_rounded,
      title: l10n.onboardingTitle1,
      message: l10n.onboardingMessage1,
    ),
    1 => OnboardingPage(
      icon: Icons.auto_awesome_rounded,
      title: l10n.onboardingTitle2,
      message: l10n.onboardingMessage2,
    ),
    2 => OnboardingPage(
      icon: Icons.widgets_rounded,
      title: l10n.onboardingTitle3,
      message: l10n.onboardingMessage3,
    ),
    _profileIndex => OnboardingProfilePage(
      nameController: _name,
      emailController: _email,
    ),
    _ => const OnboardingPermissionsPage(),
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isLast = _index == _pageCount - 1;
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
                    for (var i = 0; i < _pageCount; i++) _page(i, l10n),
                  ],
                ),
              ),
              OnboardingDots(count: _pageCount, index: _index),
              const SizedBox(height: AnjizSpacing.lg),
              AnjizButton(
                label: isLast ? l10n.actionGetStarted : l10n.actionNext,
                icon: isLast ? Icons.rocket_launch_rounded : null,
                trailingIcon: isLast ? null : Icons.arrow_forward_rounded,
                expand: true,
                size: AnjizButtonSize.large,
                onPressed: isLast ? _finish : () => _goToPage(_index + 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

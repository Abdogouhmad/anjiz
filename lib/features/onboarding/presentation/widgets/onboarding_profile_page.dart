import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/profile_photo_picker.dart';
import '../../../../l10n/app_localizations.dart';

/// The onboarding step that collects the local profile: photo, name, e-mail.
///
/// The controllers are owned by the onboarding screen so the draft survives
/// page swipes; this widget only renders and edits them.
class OnboardingProfilePage extends StatelessWidget {
  /// Creates the profile step.
  const OnboardingProfilePage({
    required this.nameController,
    required this.emailController,
    super.key,
  });

  /// Draft display name.
  final TextEditingController nameController;

  /// Draft e-mail.
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.only(top: AnjizSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.onboardingProfileTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AnjizSpacing.md12),
          Text(
            l10n.onboardingProfileMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AnjizSpacing.xl),
          const ProfilePhotoPicker(size: 96),
          const SizedBox(height: AnjizSpacing.lg),
          AnjizTextField(
            controller: nameController,
            labelText: l10n.labelName,
            hintText: l10n.hintName,
            prefixIcon: Icons.person_outline_rounded,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AnjizSpacing.md),
          AnjizTextField(
            controller: emailController,
            labelText: l10n.labelEmail,
            hintText: l10n.hintEmail,
            prefixIcon: Icons.mail_outline_rounded,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}

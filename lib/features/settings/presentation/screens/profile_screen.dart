import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/widgets/profile_photo_picker.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/profile_controller.dart';
import '../widgets/settings_sub_screen.dart';

/// Edits the local profile: photo, name and contact e-mail.
class ProfileScreen extends ConsumerStatefulWidget {
  /// Creates the profile screen.
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final TextEditingController _name;
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _name = TextEditingController(text: profile.name);
    _email = TextEditingController(text: profile.email);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _save(AppLocalizations l10n) async {
    if (_name.text.trim().isEmpty) {
      AnjizSnackBar.show(context, message: l10n.errorValidationMessage);
      return;
    }
    await ref
        .read(profileProvider.notifier)
        .save(name: _name.text, email: _email.text);
    if (!mounted) return;
    AnjizSnackBar.show(context, message: l10n.profileSaved);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SettingsSubScreen(
      title: l10n.profileTitle,
      subtitle: l10n.profileSubtitle,
      children: [
        AnjizCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfilePhotoPicker(),
              const SizedBox(height: AnjizSpacing.lg),
              AnjizTextField(
                controller: _name,
                labelText: l10n.labelName,
                hintText: l10n.hintName,
                prefixIcon: Icons.person_outline_rounded,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AnjizSpacing.md),
              AnjizTextField(
                controller: _email,
                labelText: l10n.labelEmail,
                hintText: l10n.hintEmail,
                prefixIcon: Icons.mail_outline_rounded,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        const SizedBox(height: AnjizSpacing.md),
        AnjizButton(
          label: l10n.actionSave,
          icon: Icons.check_rounded,
          variant: AnjizButtonVariant.filled,
          size: AnjizButtonSize.large,
          expand: true,
          onPressed: () => _save(l10n),
        ),
      ],
    );
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/avatar_service.dart';
import '../../../../features/settings/presentation/providers/profile_controller.dart';
import '../../../../l10n/app_localizations.dart';
import 'profile_avatar.dart';

/// The avatar with an "edit photo" affordance: camera, gallery or remove.
class ProfilePhotoPicker extends ConsumerWidget {
  /// Creates the photo picker.
  const ProfilePhotoPicker({this.size = 96, super.key});

  /// Diameter of the avatar.
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ProfileAvatar(size: size),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: Material(
              color: scheme.primary,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () => _showOptions(context, ref, l10n),
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(AnjizSpacing.sm),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: size * 0.22,
                    color: scheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showOptions(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final action = await AnjizBottomSheet.show<_PhotoAction>(
      context,
      child: AnjizSheetContent(
        title: l10n.profilePhotoTitle,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final option in _options(l10n))
              Padding(
                padding: const EdgeInsets.only(bottom: AnjizSpacing.sm),
                child: AnjizButton(
                  label: option.label,
                  icon: option.icon,
                  variant: AnjizButtonVariant.tonal,
                  expand: true,
                  onPressed: () => Navigator.of(context).pop(option.action),
                ),
              ),
          ],
        ),
      ),
    );
    if (action != null) await _apply(action, ref);
  }

  List<({IconData icon, String label, _PhotoAction action})> _options(
    AppLocalizations l10n,
  ) => [
    (
      icon: Icons.photo_camera_outlined,
      label: l10n.profileTakePhoto,
      action: _PhotoAction.camera,
    ),
    (
      icon: Icons.photo_library_outlined,
      label: l10n.profileChooseFromGallery,
      action: _PhotoAction.gallery,
    ),
    (
      icon: Icons.delete_outline_rounded,
      label: l10n.profileRemovePhoto,
      action: _PhotoAction.remove,
    ),
  ];

  Future<void> _apply(_PhotoAction action, WidgetRef ref) async {
    const service = AvatarService();
    final notifier = ref.read(profileProvider.notifier);
    if (action == _PhotoAction.remove) {
      await service.remove(ref.read(profileProvider).avatarPath);
      await notifier.clearAvatar();
      return;
    }
    final source = action == _PhotoAction.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    final path = await service.pick(source);
    if (path != null) await notifier.setAvatar(path);
  }
}

enum _PhotoAction { camera, gallery, remove }

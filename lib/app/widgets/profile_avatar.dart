import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/settings/presentation/providers/profile_controller.dart';

/// The circular profile affordance shown in every app-bar: the picked photo,
/// the user's initials, or a neutral person icon before onboarding.
class ProfileAvatar extends ConsumerWidget {
  /// Creates the avatar.
  const ProfileAvatar({this.size = 32, this.onTap, super.key});

  /// Diameter of the avatar.
  final double size;

  /// Optional tap handler.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final scheme = Theme.of(context).colorScheme;
    final avatarPath = profile.avatarPath;
    final fallback = Icon(
      Icons.person_rounded,
      size: size * 0.58,
      color: scheme.onPrimary,
    );
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: ClipOval(
        child: Container(
          width: size,
          height: size,
          color: scheme.primary,
          alignment: Alignment.center,
          child: _content(profile.initials, avatarPath, fallback, scheme),
        ),
      ),
    );
  }

  Widget _content(
    String initials,
    String? avatarPath,
    Widget fallback,
    ColorScheme scheme,
  ) {
    if (avatarPath != null && File(avatarPath).existsSync()) {
      return Image.file(
        File(avatarPath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => fallback,
      );
    }
    if (initials.isEmpty) return fallback;
    return Text(
      initials,
      style: TextStyle(
        color: scheme.onPrimary,
        fontSize: size * 0.38,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

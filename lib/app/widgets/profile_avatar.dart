import 'package:flutter/material.dart';

/// The small circular profile affordance shown in every app-bar.
class ProfileAvatar extends StatelessWidget {
  /// Creates the avatar.
  const ProfileAvatar({this.size = 32, this.onTap, super.key});

  /// Diameter of the avatar.
  final double size;

  /// Optional tap handler.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: scheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person_rounded,
          size: size * 0.58,
          color: scheme.onPrimary,
        ),
      ),
    );
  }
}

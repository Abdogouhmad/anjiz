import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/preferences_provider.dart';
import '../../../../domain/entities/user_profile.dart';

/// Loads and persists the local [UserProfile].
///
/// The profile lives in shared preferences: it is small, read synchronously on
/// every screen (avatars in app bars), and never leaves the device.
class ProfileController extends Notifier<UserProfile> {
  @override
  UserProfile build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return UserProfile(
      name: prefs.getString(AppConstants.prefProfileName) ?? '',
      email: prefs.getString(AppConstants.prefProfileEmail) ?? '',
      avatarPath: prefs.getString(AppConstants.prefProfileAvatar),
    );
  }

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  /// Persists the profile fields and updates the state.
  Future<void> save({
    required String name,
    required String email,
    String? avatarPath,
  }) async {
    state = UserProfile(
      name: name.trim(),
      email: email.trim(),
      avatarPath: avatarPath ?? state.avatarPath,
    );
    await _prefs.setString(AppConstants.prefProfileName, state.name);
    await _prefs.setString(AppConstants.prefProfileEmail, state.email);
    if (avatarPath != null) {
      await _prefs.setString(AppConstants.prefProfileAvatar, avatarPath);
    }
  }

  /// Stores the picked avatar image [path].
  Future<void> setAvatar(String path) async {
    state = state.copyWith(avatarPath: path);
    await _prefs.setString(AppConstants.prefProfileAvatar, path);
  }

  /// Removes the avatar image, falling back to initials in the UI.
  Future<void> clearAvatar() async {
    state = state.withoutAvatar();
    await _prefs.remove(AppConstants.prefProfileAvatar);
  }
}

/// Provides the local profile.
final profileProvider = NotifierProvider<ProfileController, UserProfile>(
  ProfileController.new,
);

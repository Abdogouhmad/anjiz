import 'package:characters/characters.dart';

/// The local, on-device user profile.
///
/// Anjiz is offline-first: the profile never leaves the device, and it is
/// created once during onboarding and refined later in settings.
class UserProfile {
  /// Creates a profile.
  const UserProfile({this.name = '', this.email = '', this.avatarPath});

  /// An empty profile, shown before onboarding collects anything.
  const UserProfile.empty() : this();

  /// Display name.
  final String name;

  /// Optional contact e-mail (purely local, never synced).
  final String email;

  /// Absolute path of the avatar image copied into app storage.
  final String? avatarPath;

  /// Whether nothing has been collected yet.
  bool get isEmpty => name.isEmpty && email.isEmpty && avatarPath == null;

  /// Up to two uppercase initials derived from [name].
  String get initials {
    final words = name.trim().split(RegExp(r'\s+'));
    if (words.isEmpty || words.first.isEmpty) return '';
    final buffer = StringBuffer(words.first.characters.first.toUpperCase());
    if (words.length > 1 && words.last.isNotEmpty) {
      buffer.write(words.last.characters.first.toUpperCase());
    }
    return buffer.toString();
  }

  /// Returns a copy with the given fields replaced.
  UserProfile copyWith({String? name, String? email, String? avatarPath}) =>
      UserProfile(
        name: name ?? this.name,
        email: email ?? this.email,
        avatarPath: avatarPath ?? this.avatarPath,
      );

  /// Returns a copy without the avatar image.
  UserProfile withoutAvatar() =>
      UserProfile(name: name, email: email, avatarPath: null);
}

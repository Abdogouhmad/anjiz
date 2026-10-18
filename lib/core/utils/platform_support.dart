import 'package:flutter/foundation.dart';

/// Which platform-specific features the running build can actually use.
///
/// Home-screen widgets, local notifications and background work are implemented
/// by Android/iOS-only plugins. On other targets — notably Linux desktop, which
/// is convenient for UI work — calling those plugins throws
/// `MissingPluginException`, so the owning services check these flags and
/// degrade to no-ops instead. The rest of the app is unaffected.
abstract final class PlatformSupport {
  /// Whether local notifications can be scheduled.
  static bool get notifications => _isMobile;

  /// Whether the Android home-screen widgets can be updated.
  static bool get homeWidgets =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Whether background work can be scheduled through WorkManager.
  static bool get backgroundWork => _isMobile;

  /// Whether an APK can be downloaded and handed to the package installer.
  static bool get otaUpdates =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Whether the profile photo can be picked from gallery or camera.
  static bool get avatarPicker => _isMobile;

  static bool get _isMobile =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);
}

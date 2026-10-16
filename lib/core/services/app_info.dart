import 'package:package_info_plus/package_info_plus.dart';

import '../constants/app_constants.dart';

/// The installed build's identity, read once from the platform.
///
/// The OTA updater compares [versionCode] against `update_manifest.json`, so the
/// number has to come from the package manager rather than a compile-time
/// constant: after an in-app update the running app must report the version it
/// was actually installed as. [AppConstants.version] is the fallback for the
/// targets (and tests) where `package_info_plus` has no answer.
abstract final class AppInfo {
  static String? _version;
  static int? _versionCode;

  /// Reads the installed package once; safe to call repeatedly.
  static Future<void> init() async {
    if (_version != null) return;
    try {
      final info = await PackageInfo.fromPlatform();
      _version = info.version;
      _versionCode =
          int.tryParse(info.buildNumber) ?? versionCodeOf(info.version);
    } on Object {
      // No platform channel (tests, an unsupported target): keep the
      // compile-time version so the UI still shows something truthful.
    }
  }

  /// The installed version name, e.g. `1.2.3`.
  static String get version => _version ?? AppConstants.version;

  /// The installed Android `versionCode`.
  static int get versionCode => _versionCode ?? versionCodeOf(version);

  /// Derives a versionCode from a semver name as `major*10000 + minor*100 +
  /// patch`.
  ///
  /// The same formula lives in `android/app/build.gradle.kts` and `build.sh`;
  /// changing one without the others would make the updater compare the wrong
  /// numbers.
  static int versionCodeOf(String versionName) {
    final parts = versionName
        .split('.')
        .map((part) => int.tryParse(part) ?? 0)
        .toList();
    int at(int index) => index < parts.length ? parts[index] : 0;
    return at(0) * 10000 + at(1) * 100 + at(2);
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_manifest.freezed.dart';
part 'update_manifest.g.dart';

/// The release metadata the app reads from `update_manifest.json`.
///
/// CI rewrites that file on every release: the app only needs the newest
/// [versionCode] (to decide whether to offer the update) plus the [apkUrl] and
/// [sha256] to download and verify it.
@freezed
abstract class UpdateManifest with _$UpdateManifest {
  /// Creates an update manifest.
  const factory UpdateManifest({
    required String latestVersionName,
    required int latestVersionCode,
    @Default(0) int minSupportedVersionCode,
    @Default(false) bool mandatory,
    required String apkUrl,
    required String sha256,
    @Default('') String releaseNotes,
  }) = _UpdateManifest;

  const UpdateManifest._();

  /// Parses the manifest JSON.
  factory UpdateManifest.fromJson(Map<String, dynamic> json) =>
      _$UpdateManifestFromJson(json);

  /// Whether the published release is newer than [currentVersionCode].
  bool isNewerThan(int currentVersionCode) =>
      latestVersionCode > currentVersionCode;

  /// Whether the installed build is too old to keep using, so the update cannot
  /// be postponed.
  bool isMandatoryFor(int currentVersionCode) =>
      mandatory || currentVersionCode < minSupportedVersionCode;
}

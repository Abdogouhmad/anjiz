import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ota_update/ota_update.dart';

import '../../domain/entities/update_manifest.dart';
import '../errors/update_failure.dart';
import '../utils/platform_support.dart';

/// The repository the app is published from — the single source of truth for
/// the manifest URL, so it cannot drift from the workflow that writes it.
const String kGitHubRepo = 'Abdogouhmad/anjiz';

/// Raw URL of the committed `update_manifest.json` on the default branch.
const String kUpdateManifestUrl =
    'https://raw.githubusercontent.com/$kGitHubRepo/main/update_manifest.json';

/// Reads the published release manifest and hands the APK to Android's
/// package installer.
///
/// The manifest is a plain file on the default branch, so an update check needs
/// nothing but an HTTPS GET. A failed or offline check is a normal outcome: the
/// caller decides whether to surface it.
class UpdateService {
  /// Creates an update service, optionally with a custom HTTP [client].
  UpdateService({http.Client? client}) : _client = client ?? http.Client();

  /// Upper bound on a single manifest fetch, after which it is "offline".
  static const Duration fetchTimeout = Duration(seconds: 15);

  final http.Client _client;

  /// Fetches and parses the published manifest.
  ///
  /// Throws an [UpdateException] when it cannot be read; callers treat that as
  /// "no update information", never as a crash.
  Future<UpdateManifest> fetch() async {
    // The raw.githubusercontent CDN caches aggressively; the timestamp keeps a
    // background check from being served the previous release.
    final uri = Uri.parse(
      '$kUpdateManifestUrl?t=${DateTime.now().millisecondsSinceEpoch}',
    );
    final http.Response response;
    try {
      response = await _client.get(uri).timeout(fetchTimeout);
    } on Object catch (error) {
      throw UpdateException(UpdateFailure.network, '$error');
    }
    if (response.statusCode != 200) {
      throw UpdateException(
        UpdateFailure.network,
        'manifest returned HTTP ${response.statusCode}',
      );
    }
    try {
      return UpdateManifest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } on Object catch (error) {
      throw UpdateException(UpdateFailure.malformed, '$error');
    }
  }

  /// Downloads the release APK in [manifest] and starts the installer.
  ///
  /// Reports download progress as a fraction in `[0, 1]`. The stream completes
  /// as soon as the APK has been handed to the package installer — from there
  /// the user finishes the install in Android's own UI, which puts Anjiz in the
  /// background, so there is nothing left to wait for.
  Stream<double> install(UpdateManifest manifest) async* {
    if (!PlatformSupport.otaUpdates) {
      throw const UpdateException(
        UpdateFailure.unsupported,
        'in-app updates are Android-only',
      );
    }
    // A fresh instance per attempt: `ota_update` runs one download at a time and
    // caches its event stream per instance, so reusing one would silently
    // replay the previous attempt instead of downloading again.
    final events = OtaUpdate().execute(
      manifest.apkUrl,
      destinationFilename: 'anjiz-${manifest.latestVersionName}.apk',
      sha256checksum: manifest.sha256,
    );
    await for (final event in events) {
      switch (event.status) {
        case OtaStatus.DOWNLOADING:
          yield (double.tryParse(event.value ?? '') ?? 0) / 100;
        case OtaStatus.INSTALLING:
        case OtaStatus.INSTALLATION_DONE:
          yield 1;
          return;
        case OtaStatus.CANCELED:
          throw const UpdateException(UpdateFailure.cancelled, 'cancelled');
        case OtaStatus.PERMISSION_NOT_GRANTED_ERROR:
          throw const UpdateException(
            UpdateFailure.permission,
            'Android has not allowed Anjiz to install apps',
          );
        case OtaStatus.CHECKSUM_ERROR:
          throw UpdateException(
            UpdateFailure.checksum,
            event.value ?? 'checksum mismatch',
          );
        case OtaStatus.DOWNLOAD_ERROR:
        case OtaStatus.ALREADY_RUNNING_ERROR:
          throw UpdateException(
            UpdateFailure.download,
            event.value ?? 'download failed',
          );
        case OtaStatus.INSTALLATION_ERROR:
        case OtaStatus.INTERNAL_ERROR:
          throw UpdateException(
            UpdateFailure.install,
            event.value ?? 'install failed',
          );
      }
    }
  }

  /// Releases the HTTP client.
  void dispose() => _client.close();
}

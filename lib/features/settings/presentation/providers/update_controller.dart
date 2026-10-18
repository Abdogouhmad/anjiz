import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/update_failure.dart';
import '../../../../core/services/app_info.dart';
import '../../../../core/services/preferences_provider.dart';
import '../../../../core/services/service_providers.dart';
import '../../../../domain/entities/update_manifest.dart';
import '../../../../l10n/app_localizations.dart';
import 'update_status.dart';

part 'update_controller.g.dart';

/// Owns the over-the-air update state machine: when to check, which release is
/// being offered, and how far a download has got.
@Riverpod(keepAlive: true)
class UpdateController extends _$UpdateController {
  /// How long a completed check is trusted before checking again, so opening
  /// the app repeatedly does not hammer the CDN.
  static const Duration checkInterval = Duration(hours: 6);

  @override
  UpdateStatus build() => const UpdateStatusIdle();

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  /// Checks in the background, at most once per [checkInterval].
  ///
  /// Failures are swallowed: a background check that cannot reach the network
  /// is not worth interrupting anyone over, and the settings screen can always
  /// be asked to try again.
  Future<void> autoCheck() async {
    if (state is! UpdateStatusIdle) return;
    final lastCheck = _prefs.getInt(AppConstants.prefUpdateLastCheck);
    final checkedRecently =
        lastCheck != null &&
        DateTime.now().difference(
              DateTime.fromMillisecondsSinceEpoch(lastCheck),
            ) <
            checkInterval;
    if (checkedRecently) return;
    await check(silent: true);
  }

  /// Fetches the published manifest and publishes what it found.
  Future<void> check({bool silent = false}) async {
    if (state.isBusy) return;
    state = const UpdateStatusChecking();
    try {
      final manifest = await ref.read(updateServiceProvider).fetch();
      await _prefs.setInt(
        AppConstants.prefUpdateLastCheck,
        DateTime.now().millisecondsSinceEpoch,
      );
      if (!manifest.isNewerThan(AppInfo.versionCode)) {
        state = const UpdateStatusCurrent();
        return;
      }
      state = UpdateStatusAvailable(manifest);
      await _announce(manifest);
    } on UpdateException catch (error) {
      state = silent
          ? const UpdateStatusIdle()
          : UpdateStatusFailed(error.reason);
    } on Object {
      state = silent
          ? const UpdateStatusIdle()
          : const UpdateStatusFailed(UpdateFailure.unexpected);
    }
  }

  /// Downloads the offered release and hands it to the package installer.
  Future<void> install() async {
    final manifest = state.manifest;
    if (manifest == null || state.isBusy) return;
    state = UpdateStatusDownloading(manifest, 0);
    final service = ref.read(updateServiceProvider);
    try {
      await for (final progress in service.install(manifest)) {
        // The last progress tick and the "handing over to Android" tick are the
        // same event as far as the user is concerned.
        if (progress >= 1) break;
        state = UpdateStatusDownloading(manifest, progress);
      }
      state = UpdateStatusInstalling(manifest);
    } on UpdateException catch (error) {
      state = UpdateStatusFailed(error.reason, manifest);
    } on Object {
      state = UpdateStatusFailed(UpdateFailure.unexpected, manifest);
    }
  }

  /// Tells the user once per release that an update is waiting.
  Future<void> _announce(UpdateManifest manifest) async {
    final announced = _prefs.getInt(AppConstants.prefUpdateAnnouncedVersion);
    if (announced == manifest.latestVersionCode) return;
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    await ref
        .read(notificationServiceProvider)
        .showUpdateAvailable(
          title: l10n.updateNotificationTitle,
          body: l10n.updateNotificationBody(manifest.latestVersionName),
        );
    await _prefs.setInt(
      AppConstants.prefUpdateAnnouncedVersion,
      manifest.latestVersionCode,
    );
  }
}

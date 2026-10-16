import '../../../../core/errors/update_failure.dart';
import '../../../../domain/entities/update_manifest.dart';

/// What the app knows about over-the-air updates right now.
///
/// A sealed hierarchy so every screen that renders the status has to handle
/// each state — no "loading but the button is enabled" bugs.
sealed class UpdateStatus {
  const UpdateStatus();

  /// The release being offered or installed, when there is one.
  UpdateManifest? get manifest => null;

  /// Whether a newer release than the installed one is known to exist.
  bool get hasUpdate => false;

  /// Whether a check, download or install is currently in flight.
  bool get isBusy => false;
}

/// Nothing has been checked yet this session.
class UpdateStatusIdle extends UpdateStatus {
  /// Creates the idle status.
  const UpdateStatusIdle();
}

/// A check is in flight.
class UpdateStatusChecking extends UpdateStatus {
  /// Creates the checking status.
  const UpdateStatusChecking();

  @override
  bool get isBusy => true;
}

/// The installed build is the newest published one.
class UpdateStatusCurrent extends UpdateStatus {
  /// Creates the up-to-date status.
  const UpdateStatusCurrent();
}

/// A newer release is published and can be downloaded.
class UpdateStatusAvailable extends UpdateStatus {
  /// Creates the available status for [manifest].
  const UpdateStatusAvailable(this.manifest);

  @override
  final UpdateManifest manifest;

  @override
  bool get hasUpdate => true;
}

/// The release APK is downloading; [progress] is a fraction in `[0, 1]`.
class UpdateStatusDownloading extends UpdateStatus {
  /// Creates the downloading status for [manifest].
  const UpdateStatusDownloading(this.manifest, this.progress);

  @override
  final UpdateManifest manifest;

  /// How much of the APK has arrived, from `0` to `1`.
  final double progress;

  @override
  bool get hasUpdate => true;

  @override
  bool get isBusy => true;
}

/// The APK has been handed to Android's package installer.
class UpdateStatusInstalling extends UpdateStatus {
  /// Creates the installing status for [manifest].
  const UpdateStatusInstalling(this.manifest);

  @override
  final UpdateManifest manifest;

  @override
  bool get hasUpdate => true;

  @override
  bool get isBusy => true;
}

/// The check, download or install failed.
class UpdateStatusFailed extends UpdateStatus {
  /// Creates the failed status for [reason].
  ///
  /// [manifest] is set when the failure happened while downloading or
  /// installing a known release, which lets the screen offer a retry of the
  /// install instead of a fresh check.
  const UpdateStatusFailed(this.reason, [this.manifest]);

  /// Why it failed, so the UI can say what to do about it.
  final UpdateFailure reason;

  @override
  final UpdateManifest? manifest;

  @override
  bool get hasUpdate => manifest != null;
}

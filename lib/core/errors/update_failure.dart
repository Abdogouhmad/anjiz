/// Why an update could not be checked, downloaded or installed.
///
/// The updater deliberately separates "could not reach the manifest" from "the
/// user has not allowed Anjiz to install apps yet": the second one is the
/// ordinary first-run experience on Android, and the UI tells the user how to
/// fix it instead of showing a generic failure.
enum UpdateFailure {
  /// The manifest could not be reached (offline, timeout or a bad status).
  network,

  /// The manifest was not the JSON the app expects.
  malformed,

  /// In-app updates are Android-only.
  unsupported,

  /// Android has not been told that Anjiz may install unknown apps yet.
  permission,

  /// The downloaded APK did not match the published checksum.
  checksum,

  /// The download itself failed.
  download,

  /// The package installer rejected the APK.
  install,

  /// The download was cancelled.
  cancelled,

  /// Anything else.
  unexpected,
}

/// Thrown by the update service; the presentation layer maps [reason] to copy.
class UpdateException implements Exception {
  /// Creates an update exception.
  const UpdateException(this.reason, [this.message = '']);

  /// The machine-readable reason.
  final UpdateFailure reason;

  /// Diagnostic detail (for logs, not necessarily user-facing).
  final String message;

  @override
  String toString() => 'UpdateException(${reason.name}): $message';
}

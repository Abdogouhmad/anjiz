/// Whether this device can host the Live Update focus timer.
///
/// Promoted "Live Update" notifications only exist on Android 16 (API 36) and
/// need both the platform capability and the user's notification permission,
/// so the two checks are kept apart and surfaced separately.
class PomodoroAvailability {
  /// Creates an availability value.
  const PomodoroAvailability({
    required this.platformSupported,
    required this.canPromote,
  });

  /// Availability on a device that cannot run the feature at all.
  static const PomodoroAvailability unsupported = PomodoroAvailability(
    platformSupported: false,
    canPromote: false,
  );

  /// Android 16+ is present.
  final bool platformSupported;

  /// Notifications are enabled and promoted notifications are allowed.
  final bool canPromote;

  /// Whether a run can be started and shown as a Live Update.
  bool get isAvailable => platformSupported && canPromote;

  /// Whether the platform supports the feature but the user must grant
  /// permission first.
  bool get needsPermission => platformSupported && !canPromote;
}

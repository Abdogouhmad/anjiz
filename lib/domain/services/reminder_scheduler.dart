/// Port for scheduling task reminders.
///
/// Implemented in `core/services`; use cases depend only on this abstraction so
/// the domain layer stays free of Flutter/plugin imports.
abstract interface class ReminderScheduler {
  /// Requests notification permission, returning whether it was granted.
  Future<bool> requestPermission();

  /// Schedules a one-off reminder notification.
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime at,
  });

  /// Cancels a pending reminder notification.
  Future<void> cancel(int id);
}

/// Task priority levels, ordered from lowest to highest urgency.
///
/// Stored in the database as an integer via [value] to keep the domain layer
/// free of persistence concerns.
enum Priority {
  none(0),
  low(1),
  medium(2),
  high(3);

  const Priority(this.value);

  /// Stable integer representation persisted in the database.
  final int value;

  /// Resolves a persisted [value] back to a [Priority], defaulting to [none].
  static Priority fromValue(int value) {
    return Priority.values.firstWhere(
      (priority) => priority.value == value,
      orElse: () => Priority.none,
    );
  }
}

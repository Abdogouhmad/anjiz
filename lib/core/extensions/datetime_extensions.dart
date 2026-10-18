/// Date helpers shared across features and use cases.
extension DateTimeX on DateTime {
  /// Midnight at the start of this calendar day.
  DateTime get startOfDay => DateTime(year, month, day);

  /// The last instant of this calendar day.
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Midnight tomorrow, relative to this instant.
  DateTime get startOfNextDay => DateTime(year, month, day + 1);

  /// Whether this instant falls on the same calendar day as [other].
  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  /// Whether this instant falls today, relative to [now].
  bool isToday(DateTime now) => isSameDay(now);

  /// Whether this instant falls tomorrow, relative to [now].
  bool isTomorrow(DateTime now) => DateTime(
    year,
    month,
    day,
  ).isSameDay(DateTime(now.year, now.month, now.day + 1));

  /// Midnight of the upcoming Monday (used for "next week" scheduling).
  static DateTime startOfNextWeek(DateTime now) {
    final startOfToday = DateTime(now.year, now.month, now.day);
    final daysUntilMonday = (DateTime.monday - startOfToday.weekday + 7) % 7;
    final offset = daysUntilMonday == 0 ? 7 : daysUntilMonday;
    return startOfToday.add(Duration(days: offset));
  }
}

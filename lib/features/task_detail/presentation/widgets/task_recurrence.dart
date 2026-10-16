import '../../../../l10n/app_localizations.dart';

/// Stable repeat-rule tokens persisted on a task's `repeatRule` column.
abstract final class RepeatRules {
  /// Sentinel used by the picker for "does not repeat".
  static const String none = 'NONE';

  /// Daily recurrence.
  static const String daily = 'DAILY';

  /// Weekly recurrence.
  static const String weekly = 'WEEKLY';

  /// Monthly recurrence.
  static const String monthly = 'MONTHLY';

  /// Choices offered by the repeat picker, in display order.
  static const List<String> choices = <String>[none, daily, weekly, monthly];

  /// Converts a picker choice into the persisted value (`null` for none).
  static String? normalise(String choice) => choice == none ? null : choice;

  /// Resolves the persisted [rule] to its localised label.
  static String label(AppLocalizations l10n, String? rule) => switch (rule) {
    daily => l10n.repeatDaily,
    weekly => l10n.repeatWeekly,
    monthly => l10n.repeatMonthly,
    _ => l10n.recurrenceNone,
  };
}

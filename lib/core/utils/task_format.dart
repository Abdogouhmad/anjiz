import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../extensions/datetime_extensions.dart';

/// Locale-aware formatting for task dates, times and relative due labels.
abstract final class TaskFormat {
  /// Formats the time-of-day component of [value], honouring the device's
  /// 12/24-hour preference.
  static String time(BuildContext context, DateTime value) {
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(
      TimeOfDay.fromDateTime(value),
      alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
  }

  /// A short weekday + day label, e.g. "Wed, Oct 25".
  static String dayMonth(DateTime value) =>
      DateFormat('EEE, MMM d').format(value);

  /// A long weekday label, e.g. "Thursday, Oct 26".
  static String fullDay(DateTime value) =>
      DateFormat('EEEE, MMM d').format(value);

  /// A relative day heading: "Today", "Tomorrow" or a date label.
  static String dayHeading(BuildContext context, DateTime value, DateTime now) {
    final l10n = AppLocalizations.of(context);
    if (value.isSameDay(now)) return l10n.labelToday;
    if (value.isTomorrow(now)) return l10n.labelTomorrow;
    return fullDay(value);
  }

  /// A compact countdown such as "in 2h", "in 15m" or "now".
  static String countdown(BuildContext context, DateTime target, DateTime now) {
    final l10n = AppLocalizations.of(context);
    final diff = target.difference(now);
    if (diff.isNegative) return l10n.timeNow;
    if (diff.inMinutes < 60) {
      return l10n.timeInMinutes(diff.inMinutes.clamp(1, 59));
    }
    if (diff.inHours < 24) return l10n.timeInHours(diff.inHours);
    return l10n.timeInDays(diff.inDays);
  }

  /// Formats a task's due state as a human label.
  static String dueLabel(
    BuildContext context,
    DateTime due,
    DateTime now, {
    bool hasTime = true,
  }) {
    final l10n = AppLocalizations.of(context);
    final prefix = hasTime
        ? '${dayHeading(context, due, now)} • ${time(context, due)}'
        : dayHeading(context, due, now);
    if (due.isBefore(now)) {
      return l10n.labelOverdueBy(countdown(context, now, due));
    }
    return prefix;
  }
}

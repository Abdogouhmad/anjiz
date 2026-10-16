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

  /// A compact duration such as "2h", "15m" or "3d".
  ///
  /// The sign is ignored — pass the two instants in either order — and the
  /// result carries no preposition so it can be composed into labels such as
  /// "Due in {time}" or "Overdue by {time}".
  static String countdown(BuildContext context, DateTime target, DateTime now) {
    final l10n = AppLocalizations.of(context);
    final diff = target.difference(now).abs();
    if (diff.inMinutes < 60) {
      return l10n.durationMinutes(diff.inMinutes.clamp(1, 59));
    }
    if (diff.inHours < 24) return l10n.durationHours(diff.inHours);
    return l10n.durationDays(diff.inDays);
  }

  /// Formats a task's due date and time as a human label, e.g.
  /// "Today • 11:30 AM", or just "Today" when the task carries no time.
  ///
  /// The relative state ("Due in 2h" / "Overdue by 8h") is a separate label
  /// composed from [countdown] so the row always keeps showing the real date.
  static String dueLabel(
    BuildContext context,
    DateTime due,
    DateTime now, {
    bool hasTime = true,
  }) {
    final heading = dayHeading(context, due, now);
    if (!hasTime) return heading;
    return '$heading • ${time(context, due)}';
  }
}

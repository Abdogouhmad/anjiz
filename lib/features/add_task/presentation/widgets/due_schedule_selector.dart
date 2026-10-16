import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/datetime_extensions.dart';
import '../../../../core/utils/task_format.dart';
import '../../../../l10n/app_localizations.dart';

/// Presets offered by the due-schedule selector.
enum DuePreset { today, tomorrow, nextWeek }

/// The "Due schedule" row: quick presets plus custom date/time pickers.
class DueScheduleSelector extends StatelessWidget {
  /// Creates the selector.
  const DueScheduleSelector({
    required this.due,
    required this.hasTime,
    required this.onPreset,
    required this.onPickDate,
    required this.onPickTime,
    super.key,
  });

  /// The current due date, if any.
  final DateTime? due;

  /// Whether [due] carries a time.
  final bool hasTime;

  /// Called when a preset is chosen.
  final ValueChanged<DateTime> onPreset;

  /// Called to open the date picker.
  final VoidCallback onPickDate;

  /// Called to open the time picker.
  final VoidCallback onPickTime;

  bool _isPreset(DuePreset preset, DateTime now) {
    final due = this.due;
    if (due == null) return false;
    return switch (preset) {
      DuePreset.today => due.isToday(now),
      DuePreset.tomorrow => due.isTomorrow(now),
      DuePreset.nextWeek => due.isSameDay(DateTimeX.startOfNextWeek(now)),
    };
  }

  DateTime _presetValue(DuePreset preset, DateTime now) {
    return switch (preset) {
      DuePreset.today => DateTime(now.year, now.month, now.day),
      DuePreset.tomorrow => DateTime(now.year, now.month, now.day + 1),
      DuePreset.nextWeek => DateTimeX.startOfNextWeek(now),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final due = this.due;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.labelDueSchedule.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            letterSpacing: 1,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AnjizSpacing.sm),
        Wrap(
          spacing: AnjizSpacing.sm,
          runSpacing: AnjizSpacing.sm,
          children: [
            for (final preset in DuePreset.values)
              AnjizSelectChip(
                label: switch (preset) {
                  DuePreset.today => l10n.scheduleToday,
                  DuePreset.tomorrow => l10n.scheduleTomorrow,
                  DuePreset.nextWeek => l10n.scheduleNextWeek,
                },
                selected: _isPreset(preset, now),
                onTap: () => onPreset(_presetValue(preset, now)),
              ),
            AnjizSelectChip(
              label: due == null || _isPresetDay(now)
                  ? l10n.schedulePickDate
                  : TaskFormat.dayMonth(due),
              icon: Icons.event_outlined,
              selected: due != null && !_isPresetDay(now),
              onTap: onPickDate,
            ),
            AnjizSelectChip(
              label: hasTime && due != null
                  ? TaskFormat.time(context, due)
                  : l10n.labelNoDueDate,
              icon: Icons.schedule,
              selected: hasTime,
              onTap: onPickTime,
            ),
          ],
        ),
      ],
    );
  }

  bool _isPresetDay(DateTime now) {
    for (final preset in DuePreset.values) {
      if (_isPreset(preset, now)) return true;
    }
    return false;
  }
}

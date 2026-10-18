import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/datetime_extensions.dart';

/// A horizontally scrollable strip of day chips — the expressive date selector
/// at the top of the Upcoming screen.
class UpcomingDateStrip extends StatelessWidget {
  /// Creates the date strip.
  const UpcomingDateStrip({
    required this.dates,
    required this.counts,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  /// Days shown in the strip, today first.
  final List<DateTime> dates;

  /// Number of tasks scheduled per day, parallel to [dates].
  final List<int> counts;

  /// Index of the currently selected day.
  final int selectedIndex;

  /// Called with the chosen day index.
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AnjizSpacing.sm),
        itemBuilder: (context, index) => _DayChip(
          date: dates[index],
          taskCount: counts[index],
          selected: index == selectedIndex,
          onTap: () => onSelected(index),
        ),
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.date,
    required this.taskCount,
    required this.selected,
    required this.onTap,
  });

  final DateTime date;
  final int taskCount;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final foreground = selected ? scheme.onPrimary : scheme.onSurface;
    return Semantics(
      selected: selected,
      button: true,
      label: '${date.day} ${_weekday(date)}',
      child: InkWell(
        onTap: onTap,
        borderRadius: AnjizShapes.pill,
        child: AnimatedContainer(
          duration: AnjizMotion.fast,
          width: 64,
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: AnjizSpacing.md12,
          ),
          decoration: BoxDecoration(
            color: selected ? scheme.primary : scheme.surfaceContainerLowest,
            borderRadius: AnjizShapes.card,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _weekday(date).toUpperCase(),
                style: textTheme.labelSmall?.copyWith(
                  color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: AnjizSpacing.xs),
              Text(
                '${date.day}',
                style: textTheme.headlineSmall?.copyWith(color: foreground),
              ),
              const SizedBox(height: AnjizSpacing.xs),
              _Dots(count: taskCount.clamp(0, 3), color: foreground),
            ],
          ),
        ),
      ),
    );
  }

  String _weekday(DateTime value) => DateFormat('EEE').format(value);
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.color});

  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox(height: 6);
    return SizedBox(
      height: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 2),
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Convenience: the seven day anchors starting at [now].
List<DateTime> upcomingStripDates(DateTime now) => [
  for (var i = 0; i < 7; i++) now.startOfDay.add(Duration(days: i)),
];

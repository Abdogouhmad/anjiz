import 'dart:async';

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/pomodoro_config.dart';
import '../../domain/pomodoro_phase.dart';
import '../../domain/pomodoro_run.dart';

/// The wavy ring countdown shown in the focus sheet.
///
/// Repaints from a one-second ticker purely for display; the native service
/// remains the only clock.
class PomodoroTimerDisplay extends StatefulWidget {
  /// Creates the countdown.
  const PomodoroTimerDisplay({
    required this.run,
    required this.config,
    super.key,
  });

  /// The run being displayed.
  final PomodoroRun run;

  /// Phase lengths, used for the ring progress.
  final PomodoroConfig config;

  @override
  State<PomodoroTimerDisplay> createState() => _PomodoroTimerDisplayState();
}

class _PomodoroTimerDisplayState extends State<PomodoroTimerDisplay> {
  Timer? _ticker;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final run = widget.run;
    final left = run.remainingAt(_now);
    final phaseLabel = switch (run.phase) {
      PomodoroPhase.focus => l10n.pomodoroPhaseFocus,
      PomodoroPhase.breakTime => l10n.pomodoroPhaseBreak,
      PomodoroPhase.longBreak => l10n.pomodoroPhaseLongBreak,
    };
    final time = _format(left);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SpringScale(
          scale: run.paused ? 0.94 : 1.0,
          child: AnjizWavyProgressRing(
            value: run.progressAt(
              _now,
              phaseLength: widget.config.durationFor(run.phase),
            ),
            size: 176,
            strokeWidth: 12,
            animate: !run.paused,
            color: run.phase.isBreak ? scheme.tertiary : scheme.primary,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: textTheme.displaySmall?.copyWith(
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                Text(
                  run.paused
                      ? l10n.pomodoroPausedValue(phaseLabel)
                      : phaseLabel,
                  style: textTheme.labelLarge?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AnjizSpacing.sm),
        Text(
          l10n.pomodoroSessionOf(run.session, run.totalSessions),
          style: textTheme.labelMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  String _format(Duration left) {
    final minutes = left.inMinutes;
    final seconds = left.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

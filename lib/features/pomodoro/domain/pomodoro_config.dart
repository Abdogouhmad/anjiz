import 'pomodoro_phase.dart';

/// The phase lengths that drive a run, mirrored from the persisted settings.
///
/// Kept as a value object so the presentation layer can format a countdown
/// without reaching into the settings feature.
class PomodoroConfig {
  /// Creates a config.
  const PomodoroConfig({
    required this.focusMinutes,
    required this.breakMinutes,
    required this.longBreakMinutes,
    required this.longBreakInterval,
    required this.autoStartNext,
  });

  /// Defaults used before settings load, and by the settings screen.
  static const PomodoroConfig defaults = PomodoroConfig(
    focusMinutes: 25,
    breakMinutes: 5,
    longBreakMinutes: 15,
    longBreakInterval: 4,
    autoStartNext: false,
  );

  /// The focus phase length in minutes.
  final int focusMinutes;

  /// Length of a short break.
  final int breakMinutes;

  /// Length of a long break.
  final int longBreakMinutes;

  /// Number of focus phases between two long breaks.
  final int longBreakInterval;

  /// Whether the native service starts the next phase on its own.
  final bool autoStartNext;

  /// Length of [phase] in minutes.
  int minutesFor(PomodoroPhase phase) => switch (phase) {
    PomodoroPhase.focus => focusMinutes,
    PomodoroPhase.breakTime => breakMinutes,
    PomodoroPhase.longBreak => longBreakMinutes,
  };

  /// Length of [phase] as a duration.
  Duration durationFor(PomodoroPhase phase) =>
      Duration(minutes: minutesFor(phase));
}

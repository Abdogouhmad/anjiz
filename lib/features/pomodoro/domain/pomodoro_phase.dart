/// The phases a Pomodoro run cycles through.
enum PomodoroPhase {
  /// Deep-work phase.
  focus('focus'),

  /// Short recovery between two focus phases.
  breakTime('break'),

  /// Longer recovery after a full interval of focus phases.
  longBreak('longBreak');

  const PomodoroPhase(this.wire);

  /// Stable name shared with the native service.
  final String wire;

  /// Maps a native wire name back to a phase, defaulting to [focus].
  static PomodoroPhase fromWire(String? wire) => values.firstWhere(
    (phase) => phase.wire == wire,
    orElse: () => PomodoroPhase.focus,
  );

  /// Whether this is a recovery phase rather than work.
  bool get isBreak => this != PomodoroPhase.focus;
}

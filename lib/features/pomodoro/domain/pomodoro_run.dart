import 'pomodoro_phase.dart';

/// Snapshot of the native focus timer.
///
/// The native service owns the clock: [phaseEndEpochMs] is authoritative while
/// running and [remainingMs] while paused. Dart only formats a countdown, so a
/// killed Flutter engine can never drift the timer.
class PomodoroRun {
  /// Creates a run snapshot.
  const PomodoroRun({
    required this.phase,
    required this.session,
    required this.totalSessions,
    required this.phaseEndEpochMs,
    required this.paused,
    required this.remainingMs,
    this.taskId = '',
  });

  /// Parses the map shared by `getState` and the native events.
  factory PomodoroRun.fromMap(Map<Object?, Object?> map) => PomodoroRun(
    phase: PomodoroPhase.fromWire(map['phase'] as String?),
    session: (map['session'] as num?)?.toInt() ?? 1,
    totalSessions: (map['totalSessions'] as num?)?.toInt() ?? 1,
    phaseEndEpochMs: (map['phaseEndEpochMs'] as num?)?.toInt() ?? 0,
    paused: map['paused'] as bool? ?? false,
    remainingMs: (map['remainingMs'] as num?)?.toInt() ?? 0,
    taskId: map['taskId'] as String? ?? '',
  );

  /// Phase currently running.
  final PomodoroPhase phase;

  /// 1-based index of the focus session this phase belongs to.
  final int session;

  /// Number of focus sessions in the whole run.
  final int totalSessions;

  /// Epoch milliseconds at which the phase ends; 0 while paused.
  final int phaseEndEpochMs;

  /// Whether the timer is holding.
  final bool paused;

  /// Milliseconds left; authoritative only while paused.
  final int remainingMs;

  /// Task the run belongs to, when the native side reported one.
  final String taskId;

  /// Time left in the phase as of [now].
  Duration remainingAt(DateTime now) {
    if (paused) {
      return Duration(milliseconds: remainingMs < 0 ? 0 : remainingMs);
    }
    final left = DateTime.fromMillisecondsSinceEpoch(phaseEndEpochMs)
        .difference(now);
    return left.isNegative ? Duration.zero : left;
  }

  /// Fraction of [phaseLength] already elapsed, clamped to 0..1.
  double progressAt(DateTime now, {required Duration phaseLength}) {
    final total = phaseLength.inMilliseconds;
    if (total <= 0) return 0;
    final left = remainingAt(now).inMilliseconds;
    return ((total - left) / total).clamp(0.0, 1.0);
  }
}

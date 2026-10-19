import 'pomodoro_run.dart';

/// The kinds of message the native service pushes over the method channel.
enum PomodoroEventKind {
  /// A new phase became current (also fires on start).
  phaseChanged,

  /// The timer is holding.
  paused,

  /// The timer is counting down again.
  resumed,

  /// The last focus session of the run ended.
  completed,

  /// The user tapped "Done" on the notification; the run is torn down.
  done,
}

/// A typed message pushed by the native Pomodoro service.
class PomodoroEvent {
  /// Creates an event.
  const PomodoroEvent({required this.kind, this.run, this.taskId = ''});

  /// Parses a raw channel call, returning null for unknown methods.
  static PomodoroEvent? fromCall(String method, Object? arguments) {
    final kind = switch (method) {
      'phaseChanged' => PomodoroEventKind.phaseChanged,
      'paused' => PomodoroEventKind.paused,
      'resumed' => PomodoroEventKind.resumed,
      'completed' => PomodoroEventKind.completed,
      'done' => PomodoroEventKind.done,
      _ => null,
    };
    if (kind == null) return null;
    final map = arguments is Map ? arguments : const <Object?, Object?>{};
    return PomodoroEvent(
      kind: kind,
      run: kind == PomodoroEventKind.done ? null : PomodoroRun.fromMap(map),
      taskId: map['taskId'] as String? ?? '',
    );
  }

  /// What happened.
  final PomodoroEventKind kind;

  /// Latest timer snapshot, for every event except [PomodoroEventKind.done].
  final PomodoroRun? run;

  /// Task id carried by [PomodoroEventKind.done].
  final String taskId;
}

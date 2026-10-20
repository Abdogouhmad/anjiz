import 'dart:async';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/providers/pomodoro_config.dart';
import '../../../../app/providers/use_case_providers.dart';
import '../../../../core/services/haptic_service.dart';
import '../../../../data/repositories/repository_providers.dart';
import '../../../../domain/entities/task.dart';
import '../../data/pomodoro_channel.dart';
import '../../data/pomodoro_providers.dart';
import '../../domain/pomodoro_event.dart';
import '../../domain/pomodoro_phase.dart';
import '../../domain/pomodoro_run.dart';

part 'pomodoro_controller.g.dart';

/// Mirrors the native focus timer and applies the domain side effects Dart owns.
///
/// The foreground service is the single clock: this notifier only listens to
/// its events, logs a focus session when a focus phase ends, and completes the
/// task when the notification's "Done" action fires.
@Riverpod(keepAlive: true)
class PomodoroController extends _$PomodoroController {
  /// A phase that ends within this window counts as completed rather than
  /// skipped, so `skip` never logs a partial focus session.
  static const Duration _settleWindow = Duration(seconds: 2);

  PomodoroRun? _lastRun;
  String _taskId = '';

  @override
  PomodoroRun? build() {
    final channel = ref.watch(pomodoroChannelProvider);
    final subscription = channel.events.listen(_onEvent);
    ref.onDispose(subscription.cancel);
    unawaited(_restore(channel));
    return null;
  }

  /// Whether a run is active (running or paused).
  bool get isActive => state != null;

  /// Whether [taskId] is the task currently in focus.
  bool isFor(String taskId) => state != null && _taskId == taskId;

  /// Starts (or switches to) a focus run for [task].
  Future<void> start(
    Task task, {
    required int primaryColor,
    required int tertiaryColor,
  }) async {
    final config = ref.read(pomodoroConfigProvider);
    await ref
        .read(pomodoroChannelProvider)
        .start(
          taskId: task.id,
          title: task.title,
          focusMinutes: config.focusMinutes,
          breakMinutes: config.breakMinutes,
          longBreakMinutes: config.longBreakMinutes,
          longBreakInterval: config.longBreakInterval,
          autoStartNext: config.autoStartNext,
          primaryColor: primaryColor,
          tertiaryColor: tertiaryColor,
        );
    _taskId = task.id;
  }

  /// Holds the current phase.
  Future<void> pause() => _command((channel) => channel.pause());

  /// Continues a held phase.
  Future<void> resume() => _command((channel) => channel.resume());

  /// Ends the current phase early.
  Future<void> skip() => _command((channel) => channel.skip());

  /// Tears the run down without touching the task.
  Future<void> stop() async {
    await _command((channel) => channel.stop());
    _clear();
  }

  /// Ends the run and marks [taskId] complete (the sheet's "Done" action).
  Future<void> complete(String taskId) async {
    await _command((channel) => channel.stop());
    _clear();
    await _completeTask(taskId);
  }

  Future<void> _command(
    Future<void> Function(PomodoroChannel channel) send,
  ) async {
    try {
      await send(ref.read(pomodoroChannelProvider));
    } on PlatformException {
      // The feature is unavailable; the UI already hides its controls.
    } on MissingPluginException {
      // Desktop and tests have no native service.
    }
  }

  Future<void> _restore(PomodoroChannel channel) async {
    try {
      final run = await channel.currentRun();
      if (run == null || state != null) return;
      _lastRun = run;
      _taskId = run.taskId;
      state = run;
    } on PlatformException {
      // Nothing running, or no native side.
    } on MissingPluginException {
      // Desktop and tests have no native service.
    }
  }

  void _onEvent(PomodoroEvent event) {
    switch (event.kind) {
      case PomodoroEventKind.done:
        unawaited(_finish(event.taskId));
      case PomodoroEventKind.completed:
        _logFocus();
        _apply(event.run);
        ref.read(hapticServiceProvider).success();
      case PomodoroEventKind.phaseChanged:
      case PomodoroEventKind.paused:
      case PomodoroEventKind.resumed:
        _apply(event.run);
    }
  }

  /// Advances the mirror, logging a focus session when one just ended normally.
  void _apply(PomodoroRun? run) {
    if (run == null) return;
    final previous = _lastRun;
    final endedFocus =
        previous != null &&
        previous.phase == PomodoroPhase.focus &&
        run.phase.isBreak &&
        previous.remainingAt(DateTime.now()) <= _settleWindow;
    if (endedFocus) _logFocus();
    _lastRun = run;
    state = run;
  }

  void _logFocus() {
    final taskId = _taskId;
    if (taskId.isEmpty) return;
    unawaited(
      ref
          .read(logFocusTimeProvider)
          .call(taskId, minutes: ref.read(pomodoroConfigProvider).focusMinutes),
    );
  }

  /// Completes the task behind the notification's "Done" action.
  Future<void> _finish(String taskId) async {
    final id = taskId.isEmpty ? _taskId : taskId;
    _clear();
    await _completeTask(id);
  }

  Future<void> _completeTask(String id) async {
    if (id.isEmpty) return;
    final task = await ref.read(taskRepositoryProvider).findById(id);
    if (task == null || task.isDone) return;
    await ref.read(toggleTaskDoneProvider).call(task, isDone: true);
    ref.read(hapticServiceProvider).success();
  }

  void _clear() {
    _lastRun = null;
    _taskId = '';
    state = null;
  }
}

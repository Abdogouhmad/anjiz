import 'dart:async';

import 'package:flutter/services.dart';

import '../domain/pomodoro_event.dart';
import '../domain/pomodoro_run.dart';

/// Dart end of the `anjiz/pomodoro` method channel.
///
/// Commands go down (`start`, `pause`, `resume`, `skip`, `stop`), events come
/// up. The native foreground service owns the clock, so this class never keeps
/// timer state of its own.
class PomodoroChannel {
  /// Creates the channel, optionally backed by a test [channel].
  PomodoroChannel({MethodChannel channel = const MethodChannel(channelName)})
    : _channel = channel;

  /// Name registered by `PomodoroChannelHandler` in the Android app.
  static const String channelName = 'anjiz/pomodoro';

  final MethodChannel _channel;
  final StreamController<PomodoroEvent> _events =
      StreamController<PomodoroEvent>.broadcast();

  /// Service events, broadcast so several widgets can listen at once.
  Stream<PomodoroEvent> get events => _events.stream;

  /// Starts receiving native events.
  void attach() => _channel.setMethodCallHandler(_onCall);

  /// Stops receiving events and closes the stream.
  void dispose() {
    _channel.setMethodCallHandler(null);
    unawaited(_events.close());
  }

  Future<void> _onCall(MethodCall call) async {
    final event = PomodoroEvent.fromCall(call.method, call.arguments);
    if (event != null) _events.add(event);
  }

  /// Android API level of the device.
  Future<int> sdkVersion() async =>
      await _channel.invokeMethod<int>('getSdkVersion') ?? 0;

  /// Whether the app may post promoted (Live Update) notifications.
  Future<bool> canPostPromoted() async =>
      await _channel.invokeMethod<bool>('canPostPromoted') ?? false;

  /// The persisted run, or null when nothing is running.
  Future<PomodoroRun?> currentRun() async {
    final map = await _channel.invokeMapMethod<Object?, Object?>('getState');
    return map == null ? null : PomodoroRun.fromMap(map);
  }

  /// Starts a fresh run for [taskId] and shows its Live Update.
  Future<void> start({
    required String taskId,
    required String title,
    required int focusMinutes,
    required int breakMinutes,
    required int longBreakMinutes,
    required int longBreakInterval,
    required bool autoStartNext,
    required int primaryColor,
    required int tertiaryColor,
  }) {
    return _channel.invokeMethod<void>('start', {
      'taskId': taskId,
      'title': title,
      'focusMinutes': focusMinutes,
      'breakMinutes': breakMinutes,
      'longBreakMinutes': longBreakMinutes,
      'longBreakInterval': longBreakInterval,
      'totalSessions': longBreakInterval,
      'autoStartNext': autoStartNext,
      'primaryColor': primaryColor,
      'tertiaryColor': tertiaryColor,
    });
  }

  /// Holds the current phase.
  Future<void> pause() => _channel.invokeMethod<void>('pause');

  /// Continues a held phase.
  Future<void> resume() => _channel.invokeMethod<void>('resume');

  /// Ends the current phase early.
  Future<void> skip() => _channel.invokeMethod<void>('skip');

  /// Tears the run down without completing the task.
  Future<void> stop() => _channel.invokeMethod<void>('stop');
}

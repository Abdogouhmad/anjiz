import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/pomodoro/domain/pomodoro_config.dart';
import '../../features/settings/presentation/providers/settings_controller.dart';

part 'pomodoro_config.g.dart';

/// Mirrors the persisted focus settings into the Pomodoro feature's value
/// object, so the feature never imports the settings feature directly.
@riverpod
PomodoroConfig pomodoroConfig(Ref ref) {
  final settings = ref.watch(settingsControllerProvider);
  return PomodoroConfig(
    focusMinutes: settings.focusMinutes,
    breakMinutes: settings.breakMinutes,
    longBreakMinutes: settings.longBreakMinutes,
    longBreakInterval: settings.longBreakInterval,
    autoStartNext: settings.pomodoroAutoStart,
  );
}

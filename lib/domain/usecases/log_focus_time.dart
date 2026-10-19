import '../repositories/task_repository.dart';
import '../services/widget_syncer.dart';

/// Records a completed Pomodoro focus session against its task.
///
/// The Pomodoro feature talks to tasks only through this use case (and the
/// regular completion path), keeping the repository as the single entry point.
class LogFocusTime {
  /// Creates the use case.
  const LogFocusTime({
    required TaskRepository tasks,
    required WidgetSyncer widgetSync,
  }) : _tasks = tasks,
       _widgetSync = widgetSync;

  final TaskRepository _tasks;
  final WidgetSyncer _widgetSync;

  /// Adds one focus session of [minutes] to the task and refreshes widgets.
  Future<void> call(String taskId, {required int minutes}) async {
    await _tasks.addFocusTime(taskId, minutes);
    await _widgetSync.sync();
  }
}

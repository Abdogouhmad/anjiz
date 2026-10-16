import 'dart:convert';

import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/task.dart';
import '../../domain/entities/task_list.dart';
import '../../domain/repositories/task_list_repository.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/services/widget_syncer.dart';
import '../constants/app_constants.dart';
import '../extensions/datetime_extensions.dart';

/// The single place that pushes a task snapshot to the Android home-screen
/// widgets. Called from use cases after any task mutation.
class WidgetSyncService implements WidgetSyncer {
  /// Creates a widget sync service reading from [tasks], [lists] and the
  /// persisted widget configuration in [preferences].
  WidgetSyncService(this._tasks, this._lists, this._preferences);

  final TaskRepository _tasks;
  final TaskListRepository _lists;
  final SharedPreferences _preferences;

  /// Shared-preferences key holding the serialised snapshot.
  static const String snapshotKey = 'anjiz.widget.snapshot';

  /// Maximum number of task rows handed to the native widgets.
  static const int _maxItems = 6;

  /// Builds and pushes the current snapshot, then refreshes each widget.
  ///
  /// Widget failures must never break a task mutation, so errors are swallowed.
  @override
  Future<void> sync() async {
    try {
      final tasks = await _tasks.watchAll().first;
      final lists = await _lists.watchAll().first;
      final payload = _buildSnapshot(tasks, lists, DateTime.now());
      await HomeWidget.saveWidgetData<String>(snapshotKey, jsonEncode(payload));
      for (final provider in AppConstants.widgetProviders) {
        await HomeWidget.updateWidget(
          qualifiedAndroidName: AppConstants.qualifiedWidgetProvider(provider),
        );
      }
    } on Object {
      // Intentionally ignored: widget sync is best-effort.
    }
  }

  Map<String, Object?> _buildSnapshot(
    List<Task> tasks,
    List<TaskList> lists,
    DateTime now,
  ) {
    final selectedListId = _preferences.getString(
      AppConstants.prefWidgetListId,
    );
    final showCompleted =
        _preferences.getBool(AppConstants.prefWidgetShowCompleted) ?? false;
    final opacity = _preferences.getDouble(AppConstants.prefWidgetOpacity) ?? 1;
    final scoped = selectedListId == null
        ? tasks
        : tasks.where((task) => task.listId == selectedListId).toList();
    final open = scoped.where((task) => !task.isDone).toList();
    final ordered = <Task>[
      ...open,
      if (showCompleted) ...scoped.where((task) => task.isDone),
    ];
    return {
      'updatedAt': now.toIso8601String(),
      'total': scoped.length,
      'open': open.length,
      'completedToday': tasks
          .where((task) => task.isDone && task.completedAt != null)
          .where((task) => task.completedAt!.isSameDay(now))
          .length,
      'headerTitle': _listName(lists, selectedListId),
      'showCompleted': showCompleted,
      'opacity': opacity,
      'moreCount': (ordered.length - _maxItems).clamp(0, 999),
      'items': ordered.take(_maxItems).map(_item).toList(),
    };
  }

  String? _listName(List<TaskList> lists, String? id) {
    if (id == null) return null;
    for (final list in lists) {
      if (list.id == id) return list.name;
    }
    return null;
  }

  Map<String, Object?> _item(Task task) => {
    'id': task.id,
    'title': task.title,
    'listId': task.listId,
    'isDone': task.isDone,
    'dueAt': task.dueAt?.toIso8601String(),
    'hasTime': task.hasTime,
    'priority': task.priority.value,
  };
}

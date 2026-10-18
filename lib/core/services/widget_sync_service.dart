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
import '../utils/platform_support.dart';

/// The single place that pushes a task snapshot to the Android home-screen
/// widgets. Called from use cases after any task mutation.
///
/// A no-op on platforms without `home_widget` support (e.g. desktop).
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
    if (!PlatformSupport.homeWidgets) return;
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
    final scoped = _scoped(tasks, lists);
    final today = now.startOfDay;
    final open = scoped.where((task) => !task.isDone).toList()
      ..sort((a, b) => _byUrgency(a, b, today));
    final completed = scoped.where((task) => task.isDone).toList();
    final ordered = <Task>[...open, if (showCompleted) ...completed];
    return {
      'updatedAt': now.toIso8601String(),
      'total': scoped.length,
      'open': open.length,
      // Today-scoped counters: the progress ring measures today, not all time.
      'todayTotal': _todayCount(scoped, today),
      'todayDone': completed.where((t) => _isToday(t, today)).length,
      'completedToday': completed.where((t) => _isToday(t, today)).length,
      'headerTitle': _listName(lists, selectedListId),
      'showCompleted': showCompleted,
      'opacity': opacity,
      'moreCount': (ordered.length - _maxItems).clamp(0, 999),
      'items': ordered.take(_maxItems).map(_item).toList(),
    };
  }

  /// Tasks limited to the configured list; a deleted list falls back to all
  /// tasks instead of an empty scope.
  List<Task> _scoped(List<Task> tasks, List<TaskList> lists) {
    final id = selectedListId;
    if (id == null || !lists.any((list) => list.id == id)) return tasks;
    return tasks.where((task) => task.listId == id).toList();
  }

  String? get selectedListId =>
      _preferences.getString(AppConstants.prefWidgetListId);

  bool get showCompleted =>
      _preferences.getBool(AppConstants.prefWidgetShowCompleted) ?? false;

  double get opacity =>
      _preferences.getDouble(AppConstants.prefWidgetOpacity) ?? 1;

  int _todayCount(List<Task> scoped, DateTime today) => scoped
      .where((task) => _isToday(task, today) || _isOverdue(task, today))
      .length;

  bool _isToday(Task task, DateTime today) =>
      task.dueAt?.isSameDay(today) ?? false;

  bool _isOverdue(Task task, DateTime today) {
    final due = task.dueAt;
    return due != null && due.isBefore(today);
  }

  /// Overdue first, then timed today, then undated, then further out.
  int _byUrgency(Task a, Task b, DateTime today) {
    int rank(Task task) {
      final due = task.dueAt;
      if (due == null) return 2;
      if (due.isBefore(today)) return 0;
      return due.isSameDay(today) ? 1 : 3;
    }

    final byRank = rank(a).compareTo(rank(b));
    if (byRank != 0) return byRank;
    final byPriority = b.priority.value.compareTo(a.priority.value);
    if (byPriority != 0) return byPriority;
    return (a.dueAt ?? DateTime(2100)).compareTo(b.dueAt ?? DateTime(2100));
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

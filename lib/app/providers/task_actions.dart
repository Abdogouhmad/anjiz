import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/task.dart';
import 'use_case_providers.dart';

part 'task_actions.g.dart';

/// Cross-feature task mutations, delegating to the domain use cases so screens
/// stay free of business logic.
class TaskActions {
  /// Creates the action bundle.
  const TaskActions({
    required this.toggleDone,
    required this.toggleStar,
    required this.delete,
    required this.update,
  });

  /// Toggles completion.
  final Future<void> Function(Task task, {required bool isDone}) toggleDone;

  /// Toggles the starred flag.
  final Future<void> Function(Task task, {required bool isStarred}) toggleStar;

  /// Deletes a task.
  final Future<void> Function(Task task) delete;

  /// Persists edits to a task (also used to restore a deleted task).
  final Future<void> Function(Task task) update;
}

/// Provides the shared [TaskActions].
@riverpod
TaskActions taskActions(Ref ref) {
  final toggleDone = ref.watch(toggleTaskDoneProvider);
  final toggleStar = ref.watch(toggleTaskStarProvider);
  final delete = ref.watch(deleteTaskProvider);
  final update = ref.watch(updateTaskProvider);
  return TaskActions(
    toggleDone: (task, {required isDone}) => toggleDone(task, isDone: isDone),
    toggleStar: (task, {required isStarred}) =>
        toggleStar(task, isStarred: isStarred),
    delete: delete.call,
    update: (task) => update(task),
  );
}

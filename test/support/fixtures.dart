import 'package:anjiz/domain/entities/priority.dart';
import 'package:anjiz/domain/entities/task.dart';

/// Builds a [Task] fixture with sensible defaults so tests only state the
/// fields they care about.
Task makeTask({
  String id = 'task-1',
  String listId = 'my-tasks',
  String title = 'Review brief',
  String notes = '',
  bool isDone = false,
  bool isStarred = false,
  Priority priority = Priority.none,
  DateTime? dueAt,
  bool hasTime = false,
  String? repeatRule,
  int sortOrder = 0,
  DateTime? completedAt,
  DateTime? createdAt,
}) {
  final created = createdAt ?? DateTime(2026, 10, 1, 9);
  return Task(
    id: id,
    listId: listId,
    title: title,
    notes: notes,
    isDone: isDone,
    isStarred: isStarred,
    priority: priority,
    dueAt: dueAt,
    hasTime: hasTime,
    repeatRule: repeatRule,
    sortOrder: sortOrder,
    completedAt: completedAt,
    createdAt: created,
    updatedAt: created,
  );
}

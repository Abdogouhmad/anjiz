import 'package:drift/drift.dart';

import '../../domain/entities/priority.dart';
import '../../domain/entities/task.dart';
import '../database/anjiz_database.dart';

/// Maps a drift [TaskRow] to the domain [Task] entity and back.
extension TaskRowMapper on TaskRow {
  /// Converts this row into a domain entity.
  Task toEntity() => Task(
    id: id,
    listId: listId,
    title: title,
    notes: notes,
    isDone: isDone,
    isStarred: isStarred,
    priority: Priority.fromValue(priority),
    dueAt: dueAt,
    hasTime: hasTime,
    repeatRule: repeatRule,
    sortOrder: sortOrder,
    completedAt: completedAt,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

/// Builds drift companions from domain entities.
extension TaskEntityMapper on Task {
  /// Converts this entity into an insert/update companion.
  TasksCompanion toCompanion() => TasksCompanion(
    id: Value(id),
    listId: Value(listId),
    title: Value(title),
    notes: Value(notes),
    isDone: Value(isDone),
    isStarred: Value(isStarred),
    priority: Value(priority.value),
    dueAt: Value(dueAt),
    hasTime: Value(hasTime),
    repeatRule: Value(repeatRule),
    sortOrder: Value(sortOrder),
    completedAt: Value(completedAt),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
  );
}

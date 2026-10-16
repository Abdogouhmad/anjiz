import 'package:drift/drift.dart';

import '../../domain/entities/subtask.dart';
import '../database/anjiz_database.dart';

/// Maps a drift [SubtaskRow] to the domain [Subtask] entity and back.
extension SubtaskRowMapper on SubtaskRow {
  /// Converts this row into a domain entity.
  Subtask toEntity() => Subtask(
    id: id,
    taskId: taskId,
    title: title,
    isDone: isDone,
    sortOrder: sortOrder,
  );
}

/// Builds drift companions from domain entities.
extension SubtaskEntityMapper on Subtask {
  /// Converts this entity into an insert/update companion.
  SubtasksCompanion toCompanion() => SubtasksCompanion(
    id: Value(id),
    taskId: Value(taskId),
    title: Value(title),
    isDone: Value(isDone),
    sortOrder: Value(sortOrder),
  );
}

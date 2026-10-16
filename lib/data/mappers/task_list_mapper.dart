import 'package:drift/drift.dart';

import '../../domain/entities/task_list.dart';
import '../database/anjiz_database.dart';

/// Maps a drift [TaskListRow] to the domain [TaskList] entity and back.
extension TaskListRowMapper on TaskListRow {
  /// Converts this row into a domain entity.
  TaskList toEntity() => TaskList(
    id: id,
    name: name,
    color: color,
    icon: icon,
    sortOrder: sortOrder,
    createdAt: createdAt,
  );
}

/// Builds drift companions from domain entities.
extension TaskListEntityMapper on TaskList {
  /// Converts this entity into an insert/update companion.
  TaskListsCompanion toCompanion() => TaskListsCompanion(
    id: Value(id),
    name: Value(name),
    color: Value(color),
    icon: Value(icon),
    sortOrder: Value(sortOrder),
    createdAt: Value(createdAt),
  );
}

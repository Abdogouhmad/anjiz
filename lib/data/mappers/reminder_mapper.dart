import 'package:drift/drift.dart';

import '../../domain/entities/reminder.dart';
import '../database/anjiz_database.dart';

/// Maps a drift [ReminderRow] to the domain [Reminder] entity and back.
extension ReminderRowMapper on ReminderRow {
  /// Converts this row into a domain entity.
  Reminder toEntity() => Reminder(
    id: id,
    taskId: taskId,
    remindAt: remindAt,
    notificationId: notificationId,
  );
}

/// Builds drift companions from domain entities.
extension ReminderEntityMapper on Reminder {
  /// Converts this entity into an insert/update companion.
  RemindersCompanion toCompanion() => RemindersCompanion(
    id: Value(id),
    taskId: Value(taskId),
    remindAt: Value(remindAt),
    notificationId: Value(notificationId),
  );
}

import 'package:anjiz/domain/entities/priority.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

/// A single to-do item owned by a [TaskList].
@freezed
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String listId,
    required String title,
    @Default('') String notes,
    @Default(false) bool isDone,
    @Default(false) bool isStarred,
    @Default(Priority.none) Priority priority,
    DateTime? dueAt,
    @Default(false) bool hasTime,
    String? repeatRule,
    @Default(0) int sortOrder,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Task;

  const Task._();

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// Whether the task is due before the start of [now]'s day.
  bool isOverdue(DateTime now) {
    final due = dueAt;
    if (due == null || isDone) return false;
    return due.isBefore(DateTime(now.year, now.month, now.day));
  }

  /// Whether the task falls on the same calendar day as [day].
  bool isScheduledFor(DateTime day) {
    final due = dueAt;
    if (due == null) return false;
    return due.year == day.year && due.month == day.month && due.day == day.day;
  }
}

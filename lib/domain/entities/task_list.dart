import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_list.freezed.dart';
part 'task_list.g.dart';

/// A user-defined grouping of tasks (e.g. "Work & Strategy").
@freezed
abstract class TaskList with _$TaskList {
  const factory TaskList({
    required String id,
    required String name,
    required int color,
    required String icon,
    @Default(0) int sortOrder,
    required DateTime createdAt,
  }) = _TaskList;

  factory TaskList.fromJson(Map<String, dynamic> json) =>
      _$TaskListFromJson(json);
}

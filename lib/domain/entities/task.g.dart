// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  listId: json['listId'] as String,
  title: json['title'] as String,
  notes: json['notes'] as String? ?? '',
  isDone: json['isDone'] as bool? ?? false,
  isStarred: json['isStarred'] as bool? ?? false,
  priority:
      $enumDecodeNullable(_$PriorityEnumMap, json['priority']) ?? Priority.none,
  dueAt: json['dueAt'] == null ? null : DateTime.parse(json['dueAt'] as String),
  hasTime: json['hasTime'] as bool? ?? false,
  repeatRule: json['repeatRule'] as String?,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'listId': instance.listId,
  'title': instance.title,
  'notes': instance.notes,
  'isDone': instance.isDone,
  'isStarred': instance.isStarred,
  'priority': _$PriorityEnumMap[instance.priority]!,
  'dueAt': instance.dueAt?.toIso8601String(),
  'hasTime': instance.hasTime,
  'repeatRule': instance.repeatRule,
  'sortOrder': instance.sortOrder,
  'completedAt': instance.completedAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$PriorityEnumMap = {
  Priority.none: 'none',
  Priority.low: 'low',
  Priority.medium: 'medium',
  Priority.high: 'high',
};

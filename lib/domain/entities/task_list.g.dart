// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskList _$TaskListFromJson(Map<String, dynamic> json) => _TaskList(
  id: json['id'] as String,
  name: json['name'] as String,
  color: (json['color'] as num).toInt(),
  icon: json['icon'] as String,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$TaskListToJson(_TaskList instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'icon': instance.icon,
  'sortOrder': instance.sortOrder,
  'createdAt': instance.createdAt.toIso8601String(),
};

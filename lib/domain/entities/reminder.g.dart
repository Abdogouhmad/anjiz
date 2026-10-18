// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reminder _$ReminderFromJson(Map<String, dynamic> json) => _Reminder(
  id: json['id'] as String,
  taskId: json['taskId'] as String,
  remindAt: DateTime.parse(json['remindAt'] as String),
  notificationId: (json['notificationId'] as num).toInt(),
);

Map<String, dynamic> _$ReminderToJson(_Reminder instance) => <String, dynamic>{
  'id': instance.id,
  'taskId': instance.taskId,
  'remindAt': instance.remindAt.toIso8601String(),
  'notificationId': instance.notificationId,
};

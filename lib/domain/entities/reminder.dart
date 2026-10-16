import 'package:freezed_annotation/freezed_annotation.dart';

part 'reminder.freezed.dart';
part 'reminder.g.dart';

/// A scheduled notification bound to a [Task].
@freezed
abstract class Reminder with _$Reminder {
  const factory Reminder({
    required String id,
    required String taskId,
    required DateTime remindAt,
    required int notificationId,
  }) = _Reminder;

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
}

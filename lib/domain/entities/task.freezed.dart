// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

 String get id; String get listId; String get title; String get notes; bool get isDone; bool get isStarred; Priority get priority; DateTime? get dueAt; bool get hasTime; String? get repeatRule; int get sortOrder; int get focusSessions; int get focusMinutes; DateTime? get completedAt; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.isStarred, isStarred) || other.isStarred == isStarred)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.hasTime, hasTime) || other.hasTime == hasTime)&&(identical(other.repeatRule, repeatRule) || other.repeatRule == repeatRule)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.focusSessions, focusSessions) || other.focusSessions == focusSessions)&&(identical(other.focusMinutes, focusMinutes) || other.focusMinutes == focusMinutes)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listId,title,notes,isDone,isStarred,priority,dueAt,hasTime,repeatRule,sortOrder,focusSessions,focusMinutes,completedAt,createdAt,updatedAt);

@override
String toString() {
  return 'Task(id: $id, listId: $listId, title: $title, notes: $notes, isDone: $isDone, isStarred: $isStarred, priority: $priority, dueAt: $dueAt, hasTime: $hasTime, repeatRule: $repeatRule, sortOrder: $sortOrder, focusSessions: $focusSessions, focusMinutes: $focusMinutes, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String id, String listId, String title, String notes, bool isDone, bool isStarred, Priority priority, DateTime? dueAt, bool hasTime, String? repeatRule, int sortOrder, int focusSessions, int focusMinutes, DateTime? completedAt, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? listId = null,Object? title = null,Object? notes = null,Object? isDone = null,Object? isStarred = null,Object? priority = null,Object? dueAt = freezed,Object? hasTime = null,Object? repeatRule = freezed,Object? sortOrder = null,Object? focusSessions = null,Object? focusMinutes = null,Object? completedAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,isStarred: null == isStarred ? _self.isStarred : isStarred // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,hasTime: null == hasTime ? _self.hasTime : hasTime // ignore: cast_nullable_to_non_nullable
as bool,repeatRule: freezed == repeatRule ? _self.repeatRule : repeatRule // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,focusSessions: null == focusSessions ? _self.focusSessions : focusSessions // ignore: cast_nullable_to_non_nullable
as int,focusMinutes: null == focusMinutes ? _self.focusMinutes : focusMinutes // ignore: cast_nullable_to_non_nullable
as int,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String listId,  String title,  String notes,  bool isDone,  bool isStarred,  Priority priority,  DateTime? dueAt,  bool hasTime,  String? repeatRule,  int sortOrder,  int focusSessions,  int focusMinutes,  DateTime? completedAt,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.listId,_that.title,_that.notes,_that.isDone,_that.isStarred,_that.priority,_that.dueAt,_that.hasTime,_that.repeatRule,_that.sortOrder,_that.focusSessions,_that.focusMinutes,_that.completedAt,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String listId,  String title,  String notes,  bool isDone,  bool isStarred,  Priority priority,  DateTime? dueAt,  bool hasTime,  String? repeatRule,  int sortOrder,  int focusSessions,  int focusMinutes,  DateTime? completedAt,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.listId,_that.title,_that.notes,_that.isDone,_that.isStarred,_that.priority,_that.dueAt,_that.hasTime,_that.repeatRule,_that.sortOrder,_that.focusSessions,_that.focusMinutes,_that.completedAt,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String listId,  String title,  String notes,  bool isDone,  bool isStarred,  Priority priority,  DateTime? dueAt,  bool hasTime,  String? repeatRule,  int sortOrder,  int focusSessions,  int focusMinutes,  DateTime? completedAt,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.listId,_that.title,_that.notes,_that.isDone,_that.isStarred,_that.priority,_that.dueAt,_that.hasTime,_that.repeatRule,_that.sortOrder,_that.focusSessions,_that.focusMinutes,_that.completedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task extends Task {
  const _Task({required this.id, required this.listId, required this.title, this.notes = '', this.isDone = false, this.isStarred = false, this.priority = Priority.none, this.dueAt, this.hasTime = false, this.repeatRule, this.sortOrder = 0, this.focusSessions = 0, this.focusMinutes = 0, this.completedAt, required this.createdAt, required this.updatedAt}): super._();
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override final  String id;
@override final  String listId;
@override final  String title;
@override@JsonKey() final  String notes;
@override@JsonKey() final  bool isDone;
@override@JsonKey() final  bool isStarred;
@override@JsonKey() final  Priority priority;
@override final  DateTime? dueAt;
@override@JsonKey() final  bool hasTime;
@override final  String? repeatRule;
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  int focusSessions;
@override@JsonKey() final  int focusMinutes;
@override final  DateTime? completedAt;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.listId, listId) || other.listId == listId)&&(identical(other.title, title) || other.title == title)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.isStarred, isStarred) || other.isStarred == isStarred)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.dueAt, dueAt) || other.dueAt == dueAt)&&(identical(other.hasTime, hasTime) || other.hasTime == hasTime)&&(identical(other.repeatRule, repeatRule) || other.repeatRule == repeatRule)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.focusSessions, focusSessions) || other.focusSessions == focusSessions)&&(identical(other.focusMinutes, focusMinutes) || other.focusMinutes == focusMinutes)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,listId,title,notes,isDone,isStarred,priority,dueAt,hasTime,repeatRule,sortOrder,focusSessions,focusMinutes,completedAt,createdAt,updatedAt);

@override
String toString() {
  return 'Task(id: $id, listId: $listId, title: $title, notes: $notes, isDone: $isDone, isStarred: $isStarred, priority: $priority, dueAt: $dueAt, hasTime: $hasTime, repeatRule: $repeatRule, sortOrder: $sortOrder, focusSessions: $focusSessions, focusMinutes: $focusMinutes, completedAt: $completedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String listId, String title, String notes, bool isDone, bool isStarred, Priority priority, DateTime? dueAt, bool hasTime, String? repeatRule, int sortOrder, int focusSessions, int focusMinutes, DateTime? completedAt, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? listId = null,Object? title = null,Object? notes = null,Object? isDone = null,Object? isStarred = null,Object? priority = null,Object? dueAt = freezed,Object? hasTime = null,Object? repeatRule = freezed,Object? sortOrder = null,Object? focusSessions = null,Object? focusMinutes = null,Object? completedAt = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,listId: null == listId ? _self.listId : listId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,isStarred: null == isStarred ? _self.isStarred : isStarred // ignore: cast_nullable_to_non_nullable
as bool,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,dueAt: freezed == dueAt ? _self.dueAt : dueAt // ignore: cast_nullable_to_non_nullable
as DateTime?,hasTime: null == hasTime ? _self.hasTime : hasTime // ignore: cast_nullable_to_non_nullable
as bool,repeatRule: freezed == repeatRule ? _self.repeatRule : repeatRule // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,focusSessions: null == focusSessions ? _self.focusSessions : focusSessions // ignore: cast_nullable_to_non_nullable
as int,focusMinutes: null == focusMinutes ? _self.focusMinutes : focusMinutes // ignore: cast_nullable_to_non_nullable
as int,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

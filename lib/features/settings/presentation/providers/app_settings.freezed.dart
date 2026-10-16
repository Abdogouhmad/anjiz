// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 ThemeMode get themeMode; bool get useDynamicColor; int get accentIndex; bool get burstAnimations; int get hapticLevel; bool get dailyBriefing; bool get onboardingComplete;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.useDynamicColor, useDynamicColor) || other.useDynamicColor == useDynamicColor)&&(identical(other.accentIndex, accentIndex) || other.accentIndex == accentIndex)&&(identical(other.burstAnimations, burstAnimations) || other.burstAnimations == burstAnimations)&&(identical(other.hapticLevel, hapticLevel) || other.hapticLevel == hapticLevel)&&(identical(other.dailyBriefing, dailyBriefing) || other.dailyBriefing == dailyBriefing)&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,useDynamicColor,accentIndex,burstAnimations,hapticLevel,dailyBriefing,onboardingComplete);

@override
String toString() {
  return 'AppSettings(themeMode: $themeMode, useDynamicColor: $useDynamicColor, accentIndex: $accentIndex, burstAnimations: $burstAnimations, hapticLevel: $hapticLevel, dailyBriefing: $dailyBriefing, onboardingComplete: $onboardingComplete)';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 ThemeMode themeMode, bool useDynamicColor, int accentIndex, bool burstAnimations, int hapticLevel, bool dailyBriefing, bool onboardingComplete
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? useDynamicColor = null,Object? accentIndex = null,Object? burstAnimations = null,Object? hapticLevel = null,Object? dailyBriefing = null,Object? onboardingComplete = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,useDynamicColor: null == useDynamicColor ? _self.useDynamicColor : useDynamicColor // ignore: cast_nullable_to_non_nullable
as bool,accentIndex: null == accentIndex ? _self.accentIndex : accentIndex // ignore: cast_nullable_to_non_nullable
as int,burstAnimations: null == burstAnimations ? _self.burstAnimations : burstAnimations // ignore: cast_nullable_to_non_nullable
as bool,hapticLevel: null == hapticLevel ? _self.hapticLevel : hapticLevel // ignore: cast_nullable_to_non_nullable
as int,dailyBriefing: null == dailyBriefing ? _self.dailyBriefing : dailyBriefing // ignore: cast_nullable_to_non_nullable
as bool,onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemeMode themeMode,  bool useDynamicColor,  int accentIndex,  bool burstAnimations,  int hapticLevel,  bool dailyBriefing,  bool onboardingComplete)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.themeMode,_that.useDynamicColor,_that.accentIndex,_that.burstAnimations,_that.hapticLevel,_that.dailyBriefing,_that.onboardingComplete);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemeMode themeMode,  bool useDynamicColor,  int accentIndex,  bool burstAnimations,  int hapticLevel,  bool dailyBriefing,  bool onboardingComplete)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.themeMode,_that.useDynamicColor,_that.accentIndex,_that.burstAnimations,_that.hapticLevel,_that.dailyBriefing,_that.onboardingComplete);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemeMode themeMode,  bool useDynamicColor,  int accentIndex,  bool burstAnimations,  int hapticLevel,  bool dailyBriefing,  bool onboardingComplete)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.themeMode,_that.useDynamicColor,_that.accentIndex,_that.burstAnimations,_that.hapticLevel,_that.dailyBriefing,_that.onboardingComplete);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings implements AppSettings {
  const _AppSettings({this.themeMode = ThemeMode.system, this.useDynamicColor = true, this.accentIndex = 0, this.burstAnimations = true, this.hapticLevel = 2, this.dailyBriefing = false, this.onboardingComplete = false});
  

@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  bool useDynamicColor;
@override@JsonKey() final  int accentIndex;
@override@JsonKey() final  bool burstAnimations;
@override@JsonKey() final  int hapticLevel;
@override@JsonKey() final  bool dailyBriefing;
@override@JsonKey() final  bool onboardingComplete;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.useDynamicColor, useDynamicColor) || other.useDynamicColor == useDynamicColor)&&(identical(other.accentIndex, accentIndex) || other.accentIndex == accentIndex)&&(identical(other.burstAnimations, burstAnimations) || other.burstAnimations == burstAnimations)&&(identical(other.hapticLevel, hapticLevel) || other.hapticLevel == hapticLevel)&&(identical(other.dailyBriefing, dailyBriefing) || other.dailyBriefing == dailyBriefing)&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,useDynamicColor,accentIndex,burstAnimations,hapticLevel,dailyBriefing,onboardingComplete);

@override
String toString() {
  return 'AppSettings(themeMode: $themeMode, useDynamicColor: $useDynamicColor, accentIndex: $accentIndex, burstAnimations: $burstAnimations, hapticLevel: $hapticLevel, dailyBriefing: $dailyBriefing, onboardingComplete: $onboardingComplete)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 ThemeMode themeMode, bool useDynamicColor, int accentIndex, bool burstAnimations, int hapticLevel, bool dailyBriefing, bool onboardingComplete
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? useDynamicColor = null,Object? accentIndex = null,Object? burstAnimations = null,Object? hapticLevel = null,Object? dailyBriefing = null,Object? onboardingComplete = null,}) {
  return _then(_AppSettings(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,useDynamicColor: null == useDynamicColor ? _self.useDynamicColor : useDynamicColor // ignore: cast_nullable_to_non_nullable
as bool,accentIndex: null == accentIndex ? _self.accentIndex : accentIndex // ignore: cast_nullable_to_non_nullable
as int,burstAnimations: null == burstAnimations ? _self.burstAnimations : burstAnimations // ignore: cast_nullable_to_non_nullable
as bool,hapticLevel: null == hapticLevel ? _self.hapticLevel : hapticLevel // ignore: cast_nullable_to_non_nullable
as int,dailyBriefing: null == dailyBriefing ? _self.dailyBriefing : dailyBriefing // ignore: cast_nullable_to_non_nullable
as bool,onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

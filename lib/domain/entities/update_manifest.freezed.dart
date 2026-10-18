// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateManifest {

 String get latestVersionName; int get latestVersionCode; int get minSupportedVersionCode; bool get mandatory; String get apkUrl; String get sha256; String get releaseNotes;
/// Create a copy of UpdateManifest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateManifestCopyWith<UpdateManifest> get copyWith => _$UpdateManifestCopyWithImpl<UpdateManifest>(this as UpdateManifest, _$identity);

  /// Serializes this UpdateManifest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateManifest&&(identical(other.latestVersionName, latestVersionName) || other.latestVersionName == latestVersionName)&&(identical(other.latestVersionCode, latestVersionCode) || other.latestVersionCode == latestVersionCode)&&(identical(other.minSupportedVersionCode, minSupportedVersionCode) || other.minSupportedVersionCode == minSupportedVersionCode)&&(identical(other.mandatory, mandatory) || other.mandatory == mandatory)&&(identical(other.apkUrl, apkUrl) || other.apkUrl == apkUrl)&&(identical(other.sha256, sha256) || other.sha256 == sha256)&&(identical(other.releaseNotes, releaseNotes) || other.releaseNotes == releaseNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latestVersionName,latestVersionCode,minSupportedVersionCode,mandatory,apkUrl,sha256,releaseNotes);

@override
String toString() {
  return 'UpdateManifest(latestVersionName: $latestVersionName, latestVersionCode: $latestVersionCode, minSupportedVersionCode: $minSupportedVersionCode, mandatory: $mandatory, apkUrl: $apkUrl, sha256: $sha256, releaseNotes: $releaseNotes)';
}


}

/// @nodoc
abstract mixin class $UpdateManifestCopyWith<$Res>  {
  factory $UpdateManifestCopyWith(UpdateManifest value, $Res Function(UpdateManifest) _then) = _$UpdateManifestCopyWithImpl;
@useResult
$Res call({
 String latestVersionName, int latestVersionCode, int minSupportedVersionCode, bool mandatory, String apkUrl, String sha256, String releaseNotes
});




}
/// @nodoc
class _$UpdateManifestCopyWithImpl<$Res>
    implements $UpdateManifestCopyWith<$Res> {
  _$UpdateManifestCopyWithImpl(this._self, this._then);

  final UpdateManifest _self;
  final $Res Function(UpdateManifest) _then;

/// Create a copy of UpdateManifest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latestVersionName = null,Object? latestVersionCode = null,Object? minSupportedVersionCode = null,Object? mandatory = null,Object? apkUrl = null,Object? sha256 = null,Object? releaseNotes = null,}) {
  return _then(_self.copyWith(
latestVersionName: null == latestVersionName ? _self.latestVersionName : latestVersionName // ignore: cast_nullable_to_non_nullable
as String,latestVersionCode: null == latestVersionCode ? _self.latestVersionCode : latestVersionCode // ignore: cast_nullable_to_non_nullable
as int,minSupportedVersionCode: null == minSupportedVersionCode ? _self.minSupportedVersionCode : minSupportedVersionCode // ignore: cast_nullable_to_non_nullable
as int,mandatory: null == mandatory ? _self.mandatory : mandatory // ignore: cast_nullable_to_non_nullable
as bool,apkUrl: null == apkUrl ? _self.apkUrl : apkUrl // ignore: cast_nullable_to_non_nullable
as String,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,releaseNotes: null == releaseNotes ? _self.releaseNotes : releaseNotes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateManifest].
extension UpdateManifestPatterns on UpdateManifest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateManifest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateManifest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateManifest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateManifest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateManifest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateManifest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String latestVersionName,  int latestVersionCode,  int minSupportedVersionCode,  bool mandatory,  String apkUrl,  String sha256,  String releaseNotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateManifest() when $default != null:
return $default(_that.latestVersionName,_that.latestVersionCode,_that.minSupportedVersionCode,_that.mandatory,_that.apkUrl,_that.sha256,_that.releaseNotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String latestVersionName,  int latestVersionCode,  int minSupportedVersionCode,  bool mandatory,  String apkUrl,  String sha256,  String releaseNotes)  $default,) {final _that = this;
switch (_that) {
case _UpdateManifest():
return $default(_that.latestVersionName,_that.latestVersionCode,_that.minSupportedVersionCode,_that.mandatory,_that.apkUrl,_that.sha256,_that.releaseNotes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String latestVersionName,  int latestVersionCode,  int minSupportedVersionCode,  bool mandatory,  String apkUrl,  String sha256,  String releaseNotes)?  $default,) {final _that = this;
switch (_that) {
case _UpdateManifest() when $default != null:
return $default(_that.latestVersionName,_that.latestVersionCode,_that.minSupportedVersionCode,_that.mandatory,_that.apkUrl,_that.sha256,_that.releaseNotes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateManifest extends UpdateManifest {
  const _UpdateManifest({required this.latestVersionName, required this.latestVersionCode, this.minSupportedVersionCode = 0, this.mandatory = false, required this.apkUrl, required this.sha256, this.releaseNotes = ''}): super._();
  factory _UpdateManifest.fromJson(Map<String, dynamic> json) => _$UpdateManifestFromJson(json);

@override final  String latestVersionName;
@override final  int latestVersionCode;
@override@JsonKey() final  int minSupportedVersionCode;
@override@JsonKey() final  bool mandatory;
@override final  String apkUrl;
@override final  String sha256;
@override@JsonKey() final  String releaseNotes;

/// Create a copy of UpdateManifest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateManifestCopyWith<_UpdateManifest> get copyWith => __$UpdateManifestCopyWithImpl<_UpdateManifest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateManifestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateManifest&&(identical(other.latestVersionName, latestVersionName) || other.latestVersionName == latestVersionName)&&(identical(other.latestVersionCode, latestVersionCode) || other.latestVersionCode == latestVersionCode)&&(identical(other.minSupportedVersionCode, minSupportedVersionCode) || other.minSupportedVersionCode == minSupportedVersionCode)&&(identical(other.mandatory, mandatory) || other.mandatory == mandatory)&&(identical(other.apkUrl, apkUrl) || other.apkUrl == apkUrl)&&(identical(other.sha256, sha256) || other.sha256 == sha256)&&(identical(other.releaseNotes, releaseNotes) || other.releaseNotes == releaseNotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latestVersionName,latestVersionCode,minSupportedVersionCode,mandatory,apkUrl,sha256,releaseNotes);

@override
String toString() {
  return 'UpdateManifest(latestVersionName: $latestVersionName, latestVersionCode: $latestVersionCode, minSupportedVersionCode: $minSupportedVersionCode, mandatory: $mandatory, apkUrl: $apkUrl, sha256: $sha256, releaseNotes: $releaseNotes)';
}


}

/// @nodoc
abstract mixin class _$UpdateManifestCopyWith<$Res> implements $UpdateManifestCopyWith<$Res> {
  factory _$UpdateManifestCopyWith(_UpdateManifest value, $Res Function(_UpdateManifest) _then) = __$UpdateManifestCopyWithImpl;
@override @useResult
$Res call({
 String latestVersionName, int latestVersionCode, int minSupportedVersionCode, bool mandatory, String apkUrl, String sha256, String releaseNotes
});




}
/// @nodoc
class __$UpdateManifestCopyWithImpl<$Res>
    implements _$UpdateManifestCopyWith<$Res> {
  __$UpdateManifestCopyWithImpl(this._self, this._then);

  final _UpdateManifest _self;
  final $Res Function(_UpdateManifest) _then;

/// Create a copy of UpdateManifest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latestVersionName = null,Object? latestVersionCode = null,Object? minSupportedVersionCode = null,Object? mandatory = null,Object? apkUrl = null,Object? sha256 = null,Object? releaseNotes = null,}) {
  return _then(_UpdateManifest(
latestVersionName: null == latestVersionName ? _self.latestVersionName : latestVersionName // ignore: cast_nullable_to_non_nullable
as String,latestVersionCode: null == latestVersionCode ? _self.latestVersionCode : latestVersionCode // ignore: cast_nullable_to_non_nullable
as int,minSupportedVersionCode: null == minSupportedVersionCode ? _self.minSupportedVersionCode : minSupportedVersionCode // ignore: cast_nullable_to_non_nullable
as int,mandatory: null == mandatory ? _self.mandatory : mandatory // ignore: cast_nullable_to_non_nullable
as bool,apkUrl: null == apkUrl ? _self.apkUrl : apkUrl // ignore: cast_nullable_to_non_nullable
as String,sha256: null == sha256 ? _self.sha256 : sha256 // ignore: cast_nullable_to_non_nullable
as String,releaseNotes: null == releaseNotes ? _self.releaseNotes : releaseNotes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

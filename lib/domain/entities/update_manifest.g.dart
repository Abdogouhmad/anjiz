// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateManifest _$UpdateManifestFromJson(Map<String, dynamic> json) =>
    _UpdateManifest(
      latestVersionName: json['latestVersionName'] as String,
      latestVersionCode: (json['latestVersionCode'] as num).toInt(),
      minSupportedVersionCode:
          (json['minSupportedVersionCode'] as num?)?.toInt() ?? 0,
      mandatory: json['mandatory'] as bool? ?? false,
      apkUrl: json['apkUrl'] as String,
      sha256: json['sha256'] as String,
      releaseNotes: json['releaseNotes'] as String? ?? '',
    );

Map<String, dynamic> _$UpdateManifestToJson(_UpdateManifest instance) =>
    <String, dynamic>{
      'latestVersionName': instance.latestVersionName,
      'latestVersionCode': instance.latestVersionCode,
      'minSupportedVersionCode': instance.minSupportedVersionCode,
      'mandatory': instance.mandatory,
      'apkUrl': instance.apkUrl,
      'sha256': instance.sha256,
      'releaseNotes': instance.releaseNotes,
    };

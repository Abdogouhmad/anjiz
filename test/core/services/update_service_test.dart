import 'dart:convert';

import 'package:anjiz/core/errors/update_failure.dart';
import 'package:anjiz/core/services/update_service.dart';
import 'package:anjiz/domain/entities/update_manifest.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

/// A released manifest, shaped exactly like the file CI commits.
Map<String, Object> manifestJson({
  int latestVersionCode = 10200,
  String latestVersionName = '1.2.0',
}) => {
  'latestVersionName': latestVersionName,
  'latestVersionCode': latestVersionCode,
  'minSupportedVersionCode': 10000,
  'mandatory': false,
  'apkUrl':
      'https://github.com/Abdogouhmad/anjiz/releases/download/'
      'v$latestVersionName/anjiz-v$latestVersionName-universal.apk',
  'sha256': List.filled(64, 'a').join(),
  'releaseNotes': '## [$latestVersionName]\n\n### Added\n\n- Something new.',
};

void main() {
  group('UpdateService.fetch', () {
    test('parses the published manifest', () async {
      final service = UpdateService(
        client: MockClient(
          (_) async => http.Response(jsonEncode(manifestJson()), 200),
        ),
      );
      addTearDown(service.dispose);

      final manifest = await service.fetch();

      expect(manifest.latestVersionName, '1.2.0');
      expect(manifest.latestVersionCode, 10200);
      expect(manifest.sha256, hasLength(64));
      expect(manifest.releaseNotes, contains('Something new'));
    });

    test('bypasses the CDN cache with a timestamped query', () async {
      late Uri requested;
      final service = UpdateService(
        client: MockClient((request) async {
          requested = request.url;
          return http.Response(jsonEncode(manifestJson()), 200);
        }),
      );
      addTearDown(service.dispose);

      await service.fetch();

      expect(requested.host, 'raw.githubusercontent.com');
      expect(requested.path, '/$kGitHubRepo/main/update_manifest.json');
      expect(int.parse(requested.queryParameters['t']!), greaterThan(0));
    });

    test('reports a network failure when the server says no', () async {
      final service = UpdateService(
        client: MockClient((_) async => http.Response('nope', 404)),
      );
      addTearDown(service.dispose);

      await expectLater(
        service.fetch(),
        throwsA(
          isA<UpdateException>().having(
            (error) => error.reason,
            'reason',
            UpdateFailure.network,
          ),
        ),
      );
    });

    test('reports malformed JSON instead of throwing a parse error', () async {
      final service = UpdateService(
        client: MockClient(
          (_) async => http.Response('{"not":"a manifest"}', 200),
        ),
      );
      addTearDown(service.dispose);

      await expectLater(
        service.fetch(),
        throwsA(
          isA<UpdateException>().having(
            (error) => error.reason,
            'reason',
            UpdateFailure.malformed,
          ),
        ),
      );
    });
  });

  group('UpdateService.install', () {
    test('refuses to install in-app on a non-Android target', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      addTearDown(() => debugDefaultTargetPlatformOverride = null);
      final service = UpdateService();
      addTearDown(service.dispose);
      final manifest = UpdateManifest.fromJson(manifestJson());

      await expectLater(
        service.install(manifest).first,
        throwsA(
          isA<UpdateException>().having(
            (error) => error.reason,
            'reason',
            UpdateFailure.unsupported,
          ),
        ),
      );
    });
  });
}

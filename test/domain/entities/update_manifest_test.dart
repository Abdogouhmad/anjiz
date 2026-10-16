import 'package:anjiz/domain/entities/update_manifest.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  UpdateManifest manifest({
    int latestVersionCode = 10200,
    int minSupportedVersionCode = 0,
    bool mandatory = false,
  }) => UpdateManifest(
    latestVersionName: '1.2.0',
    latestVersionCode: latestVersionCode,
    minSupportedVersionCode: minSupportedVersionCode,
    mandatory: mandatory,
    apkUrl: 'https://example.test/anjiz.apk',
    sha256: 'abc',
    releaseNotes: 'Notes',
  );

  test('offers an update only when the published versionCode is higher', () {
    final release = manifest(latestVersionCode: 10200);

    expect(release.isNewerThan(10100), isTrue);
    expect(release.isNewerThan(10200), isFalse);
    expect(release.isNewerThan(10300), isFalse);
  });

  test('flags mandatory releases and unsupported builds', () {
    expect(manifest(mandatory: true).isMandatoryFor(10200), isTrue);
    expect(
      manifest(minSupportedVersionCode: 10100).isMandatoryFor(10000),
      isTrue,
    );
    expect(
      manifest(minSupportedVersionCode: 10100).isMandatoryFor(10100),
      isFalse,
    );
    expect(manifest().isMandatoryFor(10000), isFalse);
  });

  test('falls back to safe defaults when optional fields are missing', () {
    final parsed = UpdateManifest.fromJson(const {
      'latestVersionName': '1.2.0',
      'latestVersionCode': 10200,
      'apkUrl': 'https://example.test/anjiz.apk',
      'sha256': 'abc',
    });

    expect(parsed.minSupportedVersionCode, 0);
    expect(parsed.mandatory, isFalse);
    expect(parsed.releaseNotes, isEmpty);
  });
}

import 'package:anjiz/core/constants/app_constants.dart';
import 'package:anjiz/core/errors/update_failure.dart';
import 'package:anjiz/core/services/notification_service.dart';
import 'package:anjiz/core/services/preferences_provider.dart';
import 'package:anjiz/core/services/service_providers.dart';
import 'package:anjiz/core/services/update_service.dart';
import 'package:anjiz/domain/entities/update_manifest.dart';
import 'package:anjiz/features/settings/presentation/providers/update_controller.dart';
import 'package:anjiz/features/settings/presentation/providers/update_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An update service with scripted answers and no network.
class _ScriptedUpdateService extends UpdateService {
  _ScriptedUpdateService({
    this.manifest,
    this.failure,
    this.installFailure,
    this.steps = const [1],
  });

  final UpdateManifest? manifest;
  final UpdateException? failure;
  final UpdateException? installFailure;
  final List<double> steps;

  int fetchCalls = 0;
  int installCalls = 0;

  @override
  Future<UpdateManifest> fetch() async {
    fetchCalls++;
    final failure = this.failure;
    if (failure != null) throw failure;
    return manifest!;
  }

  @override
  Stream<double> install(UpdateManifest manifest) {
    installCalls++;
    final failure = installFailure;
    if (failure != null) return Stream<double>.error(failure);
    return Stream<double>.fromIterable(steps);
  }
}

/// Records update announcements instead of posting them.
class _RecordingNotifications extends NotificationService {
  final List<String> announcements = [];

  @override
  Future<void> showUpdateAvailable({
    required String title,
    required String body,
  }) async {
    announcements.add(body);
  }
}

UpdateManifest _manifest(int versionCode) => UpdateManifest(
  latestVersionName: '1.2.0',
  latestVersionCode: versionCode,
  apkUrl: 'https://example.test/anjiz.apk',
  sha256: 'abc',
  releaseNotes: 'Notes',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // The installed build reports 1.0.0 (10000) without a platform channel.
  const newerVersionCode = 10200;
  const olderVersionCode = 10000;

  Future<
    ({
      ProviderContainer container,
      SharedPreferences prefs,
      _ScriptedUpdateService service,
      _RecordingNotifications notifications,
    })
  >
  setUpContainer(_ScriptedUpdateService service) async {
    SharedPreferences.setMockInitialValues(const {});
    final prefs = await SharedPreferences.getInstance();
    final notifications = _RecordingNotifications();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        updateServiceProvider.overrideWithValue(service),
        notificationServiceProvider.overrideWithValue(notifications),
      ],
    );
    addTearDown(container.dispose);
    return (
      container: container,
      prefs: prefs,
      service: service,
      notifications: notifications,
    );
  }

  test('starts idle and stays silent when a background check fails', () async {
    final setup = await setUpContainer(
      _ScriptedUpdateService(
        failure: const UpdateException(UpdateFailure.network),
      ),
    );
    final controller = setup.container.read(updateControllerProvider.notifier);

    await controller.autoCheck();

    expect(
      setup.container.read(updateControllerProvider),
      isA<UpdateStatusIdle>(),
    );
    expect(setup.service.fetchCalls, 1);
  });

  test('surfaces the reason when an explicit check fails', () async {
    final setup = await setUpContainer(
      _ScriptedUpdateService(
        failure: const UpdateException(UpdateFailure.malformed),
      ),
    );
    final controller = setup.container.read(updateControllerProvider.notifier);

    await controller.check();

    final status = setup.container.read(updateControllerProvider);
    expect(status, isA<UpdateStatusFailed>());
    expect((status as UpdateStatusFailed).reason, UpdateFailure.malformed);
  });

  test('publishes an available release and records the check time', () async {
    final setup = await setUpContainer(
      _ScriptedUpdateService(manifest: _manifest(newerVersionCode)),
    );
    final controller = setup.container.read(updateControllerProvider.notifier);

    await controller.check();

    final status = setup.container.read(updateControllerProvider);
    expect(status, isA<UpdateStatusAvailable>());
    expect(status.hasUpdate, isTrue);
    expect(status.manifest?.latestVersionName, '1.2.0');
    expect(setup.prefs.getInt(AppConstants.prefUpdateLastCheck), isNotNull);
    expect(setup.notifications.announcements, hasLength(1));
  });

  test('announces a release only once', () async {
    final setup = await setUpContainer(
      _ScriptedUpdateService(manifest: _manifest(newerVersionCode)),
    );
    final controller = setup.container.read(updateControllerProvider.notifier);

    await controller.check();
    await controller.check();

    expect(setup.notifications.announcements, hasLength(1));
    expect(
      setup.prefs.getInt(AppConstants.prefUpdateAnnouncedVersion),
      newerVersionCode,
    );
  });

  test('reports the installed build as current', () async {
    final setup = await setUpContainer(
      _ScriptedUpdateService(manifest: _manifest(olderVersionCode)),
    );
    final controller = setup.container.read(updateControllerProvider.notifier);

    await controller.check();

    expect(
      setup.container.read(updateControllerProvider),
      isA<UpdateStatusCurrent>(),
    );
    expect(setup.notifications.announcements, isEmpty);
  });

  test('skips a check that already ran inside the interval', () async {
    final setup = await setUpContainer(
      _ScriptedUpdateService(manifest: _manifest(newerVersionCode)),
    );
    await setup.prefs.setInt(
      AppConstants.prefUpdateLastCheck,
      DateTime.now().millisecondsSinceEpoch,
    );
    final controller = setup.container.read(updateControllerProvider.notifier);

    await controller.autoCheck();

    expect(setup.service.fetchCalls, 0);
    expect(
      setup.container.read(updateControllerProvider),
      isA<UpdateStatusIdle>(),
    );
  });

  test(
    'downloads an available release and hands it to the installer',
    () async {
      final setup = await setUpContainer(
        _ScriptedUpdateService(
          manifest: _manifest(newerVersionCode),
          steps: const [0.25, 0.5, 1],
        ),
      );
      final controller = setup.container.read(
        updateControllerProvider.notifier,
      );
      await controller.check();

      await controller.install();

      expect(setup.service.installCalls, 1);
      expect(
        setup.container.read(updateControllerProvider),
        isA<UpdateStatusInstalling>(),
      );
    },
  );

  test(
    'keeps the release when an install fails so it can be retried',
    () async {
      final setup = await setUpContainer(
        _ScriptedUpdateService(
          manifest: _manifest(newerVersionCode),
          installFailure: const UpdateException(UpdateFailure.permission),
        ),
      );
      final controller = setup.container.read(
        updateControllerProvider.notifier,
      );
      await controller.check();

      await controller.install();

      final status = setup.container.read(updateControllerProvider);
      expect(status, isA<UpdateStatusFailed>());
      expect((status as UpdateStatusFailed).reason, UpdateFailure.permission);
      expect(status.manifest, isNotNull);
    },
  );
}

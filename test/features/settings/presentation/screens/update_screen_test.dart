import 'package:anjiz/core/constants/app_constants.dart';
import 'package:anjiz/core/services/notification_service.dart';
import 'package:anjiz/core/services/preferences_provider.dart';
import 'package:anjiz/core/services/service_providers.dart';
import 'package:anjiz/core/services/update_service.dart';
import 'package:anjiz/domain/entities/update_manifest.dart';
import 'package:anjiz/features/settings/presentation/providers/update_controller.dart';
import 'package:anjiz/features/settings/presentation/screens/update_screen.dart';
import 'package:anjiz/l10n/app_localizations.dart';
import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An update service that always offers [manifest].
class _AvailableUpdateService extends UpdateService {
  _AvailableUpdateService(this.manifest);

  final UpdateManifest manifest;

  @override
  Future<UpdateManifest> fetch() async => manifest;
}

/// Swallows the update announcement.
class _QuietNotifications extends NotificationService {
  @override
  Future<void> showUpdateAvailable({
    required String title,
    required String body,
  }) async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> pumpUpdateScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 3000);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues(const {});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        notificationServiceProvider.overrideWithValue(_QuietNotifications()),
        updateServiceProvider.overrideWithValue(
          _AvailableUpdateService(
            const UpdateManifest(
              latestVersionName: '1.2.0',
              latestVersionCode: 10200,
              apkUrl: 'https://example.test/anjiz-1.2.0.apk',
              sha256: 'abc',
              releaseNotes: '### Added\n\n- Widgets can be starred.',
            ),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    await container.read(updateControllerProvider.notifier).check();
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AnjizTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const UpdateScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  testWidgets('offers the published release with its release notes', (
    tester,
  ) async {
    await pumpUpdateScreen(tester);

    expect(find.text('Version 1.2.0 is available'), findsOneWidget);
    expect(find.text('Download and install'), findsOneWidget);
    expect(find.text('What\'s new'), findsOneWidget);
    expect(find.textContaining('Widgets can be starred'), findsOneWidget);
  });

  testWidgets('reports the installed build when nothing is newer', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues(const {});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        notificationServiceProvider.overrideWithValue(_QuietNotifications()),
        updateServiceProvider.overrideWithValue(
          _AvailableUpdateService(
            const UpdateManifest(
              latestVersionName: '0.1.0',
              latestVersionCode: 100,
              apkUrl: 'https://example.test/anjiz-0.1.0.apk',
              sha256: 'abc',
            ),
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    await container.read(updateControllerProvider.notifier).check();
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AnjizTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const UpdateScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('You\'re up to date'), findsOneWidget);
    expect(find.text('Check again'), findsOneWidget);
    expect(find.text('Installed v${AppConstants.version}'), findsOneWidget);
  });
}

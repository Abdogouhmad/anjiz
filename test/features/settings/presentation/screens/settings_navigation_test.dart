import 'package:anjiz/app/app_routes.dart';
import 'package:anjiz/app/providers/task_queries.dart';
import 'package:anjiz/core/constants/app_constants.dart';
import 'package:anjiz/core/services/preferences_provider.dart';
import 'package:anjiz/domain/entities/task_list.dart';
import 'package:anjiz/features/settings/settings.dart';
import 'package:anjiz/l10n/app_localizations.dart';
import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// Mounts the `/settings` branch exactly as `router.dart` does: the hub with
  /// the feature's nested routes underneath it.
  Future<void> pumpSettings(WidgetTester tester, {String? at}) async {
    // A tall phone-shaped surface: the hub is longer than the default 600px
    // test window, and every row has to be laid out to be assertable.
    tester.view.physicalSize = const Size(1200, 3000);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues(const {});
    final prefs = await SharedPreferences.getInstance();
    final router = GoRouter(
      initialLocation: at ?? AppRoutes.settings,
      routes: [
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => const SettingsScreen(),
          routes: settingsRoutes(),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          taskListsProvider.overrideWith(
            (ref) => Stream.value(const <TaskList>[]),
          ),
        ],
        child: MaterialApp.router(
          theme: AnjizTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Taps the back button belonging to [screen] rather than whichever back
  /// button happens to be first in the widget tree.
  Future<void> tapBack(WidgetTester tester, Type screen) async {
    await tester.tap(
      find.descendant(
        of: find.byType(screen),
        matching: find.byType(BackButton),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> open(WidgetTester tester, String title) async {
    final target = find.text(title);
    // The hub is taller than the test surface, so scroll the row into view
    // before tapping it.
    await tester.scrollUntilVisible(
      target,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -80));
    await tester.pumpAndSettle();
    await tester.tap(target, warnIfMissed: false);
    await tester.pumpAndSettle();
  }

  testWidgets('the hub lists every settings section', (tester) async {
    await pumpSettings(tester);

    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(find.text('Preferences'), findsOneWidget);
    expect(find.text('General'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    // Rows name their current value, so the hub reads as a status page.
    expect(find.text('System · Material You'), findsOneWidget);
    expect(find.text('Daily briefing off'), findsOneWidget);
    expect(find.text('Data & Backup'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('Anjiz v${AppConstants.version}'), findsOneWidget);
  });

  testWidgets('General opens the theme and motion sections', (tester) async {
    await pumpSettings(tester);

    await open(tester, 'General');

    expect(find.byType(GeneralSettingsScreen), findsOneWidget);
    expect(find.text('Theme'), findsOneWidget);
    expect(find.text('Motion & haptics'), findsOneWidget);
  });

  testWidgets('Theme is a third level and pops back to General', (
    tester,
  ) async {
    await pumpSettings(tester);

    await open(tester, 'General');
    await open(tester, 'Theme');

    expect(find.byType(ThemeSettingsScreen), findsOneWidget);
    expect(find.text('Dynamic Color'), findsOneWidget);
    expect(find.text('Pure black (OLED)'), findsOneWidget);

    await tapBack(tester, ThemeSettingsScreen);

    expect(find.byType(ThemeSettingsScreen), findsNothing);
    expect(find.byType(GeneralSettingsScreen), findsOneWidget);
  });

  testWidgets('Motion opens from General', (tester) async {
    await pumpSettings(tester);

    await open(tester, 'General');
    await open(tester, 'Motion & haptics');

    expect(find.byType(MotionSettingsScreen), findsOneWidget);
    expect(find.text('Spring Haptics'), findsOneWidget);
  });

  testWidgets('Notifications links on to the widget configuration', (
    tester,
  ) async {
    await pumpSettings(tester);

    await open(tester, 'Notifications');
    expect(find.byType(NotificationsSettingsScreen), findsOneWidget);
    expect(find.text('Daily Briefing'), findsOneWidget);

    await open(tester, 'Widget Configuration & Previews');

    expect(find.byType(WidgetConfigScreen), findsOneWidget);
    expect(find.text('Choose list'), findsOneWidget);

    await tapBack(tester, WidgetConfigScreen);

    expect(find.byType(NotificationsSettingsScreen), findsOneWidget);
  });

  testWidgets('Data opens the calendar and export controls', (tester) async {
    await pumpSettings(tester);

    await open(tester, 'Data & Backup');

    expect(find.byType(DataSettingsScreen), findsOneWidget);
    expect(find.text('Google Calendar'), findsOneWidget);
    expect(find.text('JSON'), findsOneWidget);
  });

  testWidgets('About opens the licence page', (tester) async {
    await pumpSettings(tester);

    await open(tester, 'About');

    expect(find.byType(AboutScreen), findsOneWidget);
    expect(find.text('Open-source licences'), findsOneWidget);

    final licencesFinder = find.text('Open-source licences');
    await tester.scrollUntilVisible(
      licencesFinder,
      150,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(licencesFinder);
    await tester.pumpAndSettle();

    expect(find.byType(LicensePage), findsOneWidget);
  });

  testWidgets('a deep link builds the whole settings stack', (tester) async {
    await pumpSettings(tester, at: AppRoutes.settingsTheme);

    // The hub and the General section sit below the theme screen, so they are
    // in the tree but offstage.
    expect(find.byType(SettingsScreen, skipOffstage: false), findsOneWidget);
    expect(
      find.byType(GeneralSettingsScreen, skipOffstage: false),
      findsOneWidget,
    );
    expect(find.byType(ThemeSettingsScreen), findsOneWidget);

    await tapBack(tester, ThemeSettingsScreen);
    await tapBack(tester, GeneralSettingsScreen);

    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(
      find.byType(GeneralSettingsScreen, skipOffstage: false),
      findsNothing,
    );
  });
}

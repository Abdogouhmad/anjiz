import 'package:anjiz/core/constants/app_constants.dart';
import 'package:anjiz/core/services/preferences_provider.dart';
import 'package:anjiz/features/settings/presentation/providers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<({ProviderContainer container, SharedPreferences prefs})>
  setUpContainer(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues(values);
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);
    return (container: container, prefs: prefs);
  }

  test('reads persisted settings, falling back to defaults', () async {
    final setup = await setUpContainer({
      AppConstants.prefThemeMode: ThemeMode.dark.index,
      AppConstants.prefAccentIndex: 3,
    });

    final settings = setup.container.read(settingsControllerProvider);

    expect(settings.themeMode, ThemeMode.dark);
    expect(settings.accentIndex, 3);
    expect(settings.useDynamicColor, isTrue);
    expect(settings.onboardingComplete, isFalse);
  });

  test('writes each change back to shared preferences', () async {
    final setup = await setUpContainer(const {});
    final controller = setup.container.read(
      settingsControllerProvider.notifier,
    );

    await controller.setThemeMode(ThemeMode.light);
    await controller.setDynamicColor(enabled: false);
    await controller.setAccentIndex(2);
    await controller.setBurstAnimations(enabled: false);
    await controller.setHapticLevel(0);
    await controller.setDailyBriefing(enabled: true);
    await controller.completeOnboarding();
    await controller.setPureBlack(enabled: true);

    expect(
      setup.prefs.getInt(AppConstants.prefThemeMode),
      ThemeMode.light.index,
    );
    expect(setup.prefs.getBool(AppConstants.prefDynamicColor), isFalse);
    expect(setup.prefs.getInt(AppConstants.prefAccentIndex), 2);
    expect(setup.prefs.getBool(AppConstants.prefBurstAnimations), isFalse);
    expect(setup.prefs.getInt(AppConstants.prefHapticLevel), 0);
    expect(setup.prefs.getBool(AppConstants.prefDailyBriefing), isTrue);
    expect(setup.prefs.getBool(AppConstants.prefOnboardingDone), isTrue);
    expect(setup.prefs.getBool(AppConstants.prefPureBlack), isTrue);

    final settings = setup.container.read(settingsControllerProvider);
    expect(settings.themeMode, ThemeMode.light);
    expect(settings.accentIndex, 2);
    expect(settings.hapticLevel, 0);
    expect(settings.usePureBlack, isTrue);
  });

  test('resolves the accent seed for an index', () {
    expect(accentSeedFor(0), const Color(0xFF1B7A66));
    expect(accentSeedFor(99), const Color(0xFF826117));
  });
}

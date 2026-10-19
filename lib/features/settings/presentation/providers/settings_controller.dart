import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/haptic_service.dart';
import '../../../../core/services/preferences_provider.dart';
import 'accent_tones.dart';
import 'app_settings.dart';

part 'settings_controller.g.dart';

/// Owns the persisted [AppSettings], reading them synchronously from
/// [sharedPreferencesProvider].
@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  AppSettings build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final modeIndex = prefs.getInt(AppConstants.prefThemeMode);
    return AppSettings(
      themeMode: modeIndex == null
          ? ThemeMode.system
          : ThemeMode.values[modeIndex.clamp(0, ThemeMode.values.length - 1)],
      useDynamicColor: prefs.getBool(AppConstants.prefDynamicColor) ?? true,
      accentIndex: prefs.getInt(AppConstants.prefAccentIndex) ?? 0,
      usePureBlack: prefs.getBool(AppConstants.prefPureBlack) ?? false,
      burstAnimations: prefs.getBool(AppConstants.prefBurstAnimations) ?? true,
      hapticLevel: prefs.getInt(AppConstants.prefHapticLevel) ?? 2,
      dailyBriefing: prefs.getBool(AppConstants.prefDailyBriefing) ?? false,
      onboardingComplete:
          prefs.getBool(AppConstants.prefOnboardingDone) ?? false,
      focusMinutes: prefs.getInt(AppConstants.prefPomodoroFocusMinutes) ?? 25,
      breakMinutes: prefs.getInt(AppConstants.prefPomodoroBreakMinutes) ?? 5,
      longBreakMinutes:
          prefs.getInt(AppConstants.prefPomodoroLongBreakMinutes) ?? 15,
      longBreakInterval:
          prefs.getInt(AppConstants.prefPomodoroLongBreakInterval) ?? 4,
      pomodoroAutoStart:
          prefs.getBool(AppConstants.prefPomodoroAutoStart) ?? false,
    );
  }

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  /// Updates the theme mode.
  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    await _prefs.setInt(AppConstants.prefThemeMode, mode.index);
  }

  /// Toggles Material You dynamic colour.
  Future<void> setDynamicColor({required bool enabled}) async {
    state = state.copyWith(useDynamicColor: enabled);
    await _prefs.setBool(AppConstants.prefDynamicColor, enabled);
  }

  /// Selects an accent tone by index into [kAccentSeeds].
  Future<void> setAccentIndex(int index) async {
    state = state.copyWith(accentIndex: index);
    await _prefs.setInt(AppConstants.prefAccentIndex, index);
  }

  /// Toggles the pure-black (OLED) dark theme.
  Future<void> setPureBlack({required bool enabled}) async {
    state = state.copyWith(usePureBlack: enabled);
    await _prefs.setBool(AppConstants.prefPureBlack, enabled);
  }

  /// Toggles the celebratory burst animations.
  Future<void> setBurstAnimations({required bool enabled}) async {
    state = state.copyWith(burstAnimations: enabled);
    await _prefs.setBool(AppConstants.prefBurstAnimations, enabled);
    if (enabled) {
      ref.read(hapticServiceProvider).success();
    }
  }

  /// Sets the haptic intensity level (0–2).
  Future<void> setHapticLevel(int level) async {
    state = state.copyWith(hapticLevel: level);
    await _prefs.setInt(AppConstants.prefHapticLevel, level);
    ref.invalidate(hapticLevelProvider);
    ref.read(hapticServiceProvider).tap();
  }

  /// Toggles the daily briefing.
  Future<void> setDailyBriefing({required bool enabled}) async {
    state = state.copyWith(dailyBriefing: enabled);
    await _prefs.setBool(AppConstants.prefDailyBriefing, enabled);
  }

  /// Sets the focus-phase length in minutes.
  Future<void> setFocusMinutes(int minutes) async {
    state = state.copyWith(focusMinutes: minutes);
    await _prefs.setInt(AppConstants.prefPomodoroFocusMinutes, minutes);
  }

  /// Sets the short-break length in minutes.
  Future<void> setBreakMinutes(int minutes) async {
    state = state.copyWith(breakMinutes: minutes);
    await _prefs.setInt(AppConstants.prefPomodoroBreakMinutes, minutes);
  }

  /// Sets the long-break length in minutes.
  Future<void> setLongBreakMinutes(int minutes) async {
    state = state.copyWith(longBreakMinutes: minutes);
    await _prefs.setInt(AppConstants.prefPomodoroLongBreakMinutes, minutes);
  }

  /// Sets how many focus phases precede a long break.
  Future<void> setLongBreakInterval(int sessions) async {
    state = state.copyWith(longBreakInterval: sessions);
    await _prefs.setInt(AppConstants.prefPomodoroLongBreakInterval, sessions);
  }

  /// Toggles auto-starting the phase after the current one.
  Future<void> setPomodoroAutoStart({required bool enabled}) async {
    state = state.copyWith(pomodoroAutoStart: enabled);
    await _prefs.setBool(AppConstants.prefPomodoroAutoStart, enabled);
  }

  /// Marks onboarding as completed.
  Future<void> completeOnboarding() async {
    state = state.copyWith(onboardingComplete: true);
    await _prefs.setBool(AppConstants.prefOnboardingDone, true);
  }
}

/// Resolves the accent seed colour for the given [index].
Color accentSeedFor(int index) =>
    Color(kAccentSeeds[index.clamp(0, kAccentSeeds.length - 1)]);

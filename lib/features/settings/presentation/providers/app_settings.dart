import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

/// User-controlled appearance and behaviour settings.
@freezed
abstract class AppSettings with _$AppSettings {
  /// Creates the settings value.
  const factory AppSettings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(true) bool useDynamicColor,
    @Default(0) int accentIndex,
    @Default(false) bool usePureBlack,
    @Default(true) bool burstAnimations,
    @Default(2) int hapticLevel,
    @Default(false) bool dailyBriefing,
    @Default(false) bool onboardingComplete,
  }) = _AppSettings;
}

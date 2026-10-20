import 'package:flutter/material.dart';

import '../../../core/services/app_info.dart';
import '../../../l10n/app_localizations.dart';
import 'providers/accent_tones.dart';
import 'providers/app_settings.dart';
import 'providers/update_status.dart';

/// One-line value summaries for settings rows.
///
/// A row's subtitle names the value it currently holds ("Dark · Emerald")
/// rather than describing the screen it opens, so the hub answers "is my app
/// still set up the way I left it?" without a trip down the stack.
String themeSummary(AppLocalizations l10n, AppSettings settings) {
  final mode = switch (settings.themeMode) {
    ThemeMode.light => l10n.themeLight,
    ThemeMode.dark => l10n.themeDark,
    ThemeMode.system => l10n.themeSystem,
  };
  final accent = settings.useDynamicColor
      ? l10n.tagMaterialYou
      : accentLabel(l10n, settings.accentIndex);
  return '$mode · $accent';
}

/// The current spring-haptics level, e.g. "Expressive".
String hapticSummary(AppLocalizations l10n, AppSettings settings) {
  return switch (settings.hapticLevel) {
    0 => l10n.hapticOff,
    1 => l10n.hapticSubtle,
    _ => l10n.hapticExpressive,
  };
}

/// The current Pomodoro rhythm, e.g. "25 min · 4 sessions".
String focusSummary(AppLocalizations l10n, AppSettings settings) =>
    '${l10n.pomodoroMinutesValue(settings.focusMinutes)} · '
    '${l10n.pomodoroSessionsValue(settings.longBreakInterval)}';

/// The current update state, e.g. "Version 1.0.1 is ready".
String updateSummary(AppLocalizations l10n, UpdateStatus status) {
  return switch (status) {
    UpdateStatusAvailable(:final manifest) => l10n.updateAvailableSummary(
      manifest.latestVersionName,
    ),
    UpdateStatusDownloading() => l10n.updateDownloading,
    UpdateStatusInstalling() => l10n.updateInstalling,
    UpdateStatusChecking() => l10n.updateChecking,
    UpdateStatusFailed() => l10n.updateCheckFailed,
    UpdateStatusIdle() ||
    UpdateStatusCurrent() => l10n.updateCurrentSummary(AppInfo.version),
  };
}

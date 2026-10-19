/// Stable string keys and ids used across Anjiz.
abstract final class AppConstants {
  /// Human-readable application version shown in the settings footer.
  static const String version = '0.1.1';

  /// Id of the list created on first launch.
  static const String defaultListId = 'my-tasks';

  /// Id used for tasks captured without an explicit list.
  static const String inboxListId = 'inbox';

  /// Shared-preferences key for the theme-mode setting.
  static const String prefThemeMode = 'settings.themeMode';

  /// Shared-preferences key for the dynamic-colour setting.
  static const String prefDynamicColor = 'settings.dynamicColor';

  /// Shared-preferences key for the accent-tone index.
  static const String prefAccentIndex = 'settings.accentIndex';

  /// Shared-preferences key for the pure-black (OLED) dark theme.
  static const String prefPureBlack = 'settings.pureBlack';

  /// Shared-preferences key for the celebration-animation setting.
  static const String prefBurstAnimations = 'settings.burstAnimations';

  /// Shared-preferences key for the haptic intensity level.
  static const String prefHapticLevel = 'settings.hapticLevel';

  /// Shared-preferences key for the daily-briefing setting.
  static const String prefDailyBriefing = 'settings.dailyBriefing';

  /// Shared-preferences key storing whether onboarding has been completed.
  static const String prefOnboardingDone = 'settings.onboardingDone';

  /// Shared-preferences key for the focus-phase length in minutes.
  static const String prefPomodoroFocusMinutes =
      'settings.pomodoro.focusMinutes';

  /// Shared-preferences key for the short-break length in minutes.
  static const String prefPomodoroBreakMinutes =
      'settings.pomodoro.breakMinutes';

  /// Shared-preferences key for the long-break length in minutes.
  static const String prefPomodoroLongBreakMinutes =
      'settings.pomodoro.longBreakMinutes';

  /// Shared-preferences key for how many focus phases precede a long break.
  static const String prefPomodoroLongBreakInterval =
      'settings.pomodoro.longBreakInterval';

  /// Shared-preferences key for auto-starting the next phase.
  static const String prefPomodoroAutoStart = 'settings.pomodoro.autoStart';

  /// Shared-preferences key for the widget's selected list id.
  static const String prefWidgetListId = 'widget.listId';

  /// Shared-preferences key for showing completed tasks in widgets.
  static const String prefWidgetShowCompleted = 'widget.showCompleted';

  /// Shared-preferences key for the widget background opacity.
  static const String prefWidgetOpacity = 'widget.opacity';

  /// Android notification channel id for task reminders.
  static const String reminderChannelId = 'anjiz.reminders';

  /// Android notification channel id for the daily briefing.
  static const String briefingChannelId = 'anjiz.briefing';

  /// Android notification channel id for "a new version is available".
  static const String updatesChannelId = 'anjiz.updates';

  /// Android notification channel id for the Pomodoro Live Update timer.
  ///
  /// Must match `PomodoroContract.CHANNEL_LIVE` on the native side.
  static const String pomodoroChannelLiveId = 'pomodoro';

  /// Android notification channel id for one-shot Pomodoro phase alerts.
  ///
  /// Must match `PomodoroContract.CHANNEL_ALERT` on the native side.
  static const String pomodoroChannelAlertId = 'pomodoro_alert';

  /// Notification id used for the update announcement (never reused).
  static const int updateNotificationId = 99;

  /// Notification id used for the manual notification test.
  static const int testNotificationId = 98;

  /// Notification id used for the recurring daily briefing.
  static const int dailyBriefingNotificationId = 97;

  /// Local hour at which the daily briefing fires.
  static const int dailyBriefingHour = 8;

  /// Shared-preferences key for the profile display name.
  static const String prefProfileName = 'profile.name';

  /// Shared-preferences key for the profile e-mail.
  static const String prefProfileEmail = 'profile.email';

  /// Shared-preferences key for the profile avatar image path.
  static const String prefProfileAvatar = 'profile.avatar';

  /// Shared-preferences key for the last update check (epoch milliseconds).
  static const String prefUpdateLastCheck = 'update.lastCheckAt';

  /// Shared-preferences key for the last version code announced (so one release
  /// is never announced twice).
  static const String prefUpdateAnnouncedVersion =
      'update.announcedVersionCode';

  /// Android package holding the Glance widget providers.
  static const String androidWidgetPackage = 'com.freesoftware.anjiz.widget';

  /// Widget provider class for the 4x4 tasks-overview widget.
  static const String widgetTasksOverview = 'TasksOverviewWidgetProvider';

  /// Widget provider class for the 2x2 progress ring widget.
  static const String widgetProgress = 'ProgressWidgetProvider';

  /// Widget provider class for the 4x1 quick-add widget.
  static const String widgetQuickAdd = 'QuickAddWidgetProvider';

  /// Every widget provider, refreshed after each task mutation.
  static const List<String> widgetProviders = [
    widgetTasksOverview,
    widgetProgress,
    widgetQuickAdd,
  ];

  /// Builds the fully-qualified Android component name for a widget [name].
  static String qualifiedWidgetProvider(String name) =>
      '$androidWidgetPackage.$name';

  /// Deep-link scheme used by the home-screen widgets.
  static const String widgetScheme = 'anjiz';

  /// Deep-link host that opens the quick-add composer.
  static const String widgetQuickAddHost = 'quick-add';

  /// Deep-link host that groups task interactions (`toggle`, `star`).
  static const String widgetTaskHost = 'task';

  /// Query parameter carrying the tapped task id.
  static const String widgetTaskIdParam = 'id';

  /// Unique workmanager task name for midnight widget refresh.
  static const String workMidnightRefresh = 'anjiz.midnightRefresh';

  /// Background isolate entry-point name for widget tap-to-complete.
  static const String widgetBackgroundCallback = 'anjizWidgetCallback';
}

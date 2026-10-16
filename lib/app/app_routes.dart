/// Route paths and builders for the Anjiz router.
abstract final class AppRoutes {
  /// The Today tab (also the initial location).
  static const String today = '/today';

  /// The Upcoming tab.
  static const String upcoming = '/upcoming';

  /// The Lists tab.
  static const String lists = '/lists';

  /// The full-screen search route.
  static const String search = '/search';

  /// The settings tab (also a nested settings hub).
  static const String settings = '/settings';

  /// The nested settings screens.
  static const String settingsGeneral = '/settings/general';

  /// Theme controls, nested under General.
  static const String settingsTheme = '/settings/general/theme';

  /// Motion and haptics controls, nested under General.
  static const String settingsMotion = '/settings/general/motion';

  /// Notification and widget settings.
  static const String settingsNotifications = '/settings/notifications';

  /// The home-screen widget configuration screen.
  static const String settingsWidgets = '/settings/widgets';

  /// Data, calendar and export settings.
  static const String settingsData = '/settings/data';

  /// Version, licences and credits.
  static const String settingsAbout = '/settings/about';

  /// The over-the-air app update screen.
  static const String settingsUpdate = '/settings/update';

  /// The onboarding route.
  static const String onboarding = '/onboarding';

  /// The task-detail route pattern.
  static const String taskPattern = '/task/:taskId';

  /// The list-detail route pattern.
  static const String listPattern = '/list/:listId';

  /// Builds the task-detail location for [taskId].
  static String task(String taskId) => '/task/$taskId';

  /// Builds the list-detail location for [listId].
  static String list(String listId) => '/list/$listId';
}

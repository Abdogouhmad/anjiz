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

  /// The settings route.
  static const String settings = '/settings';

  /// The home-screen widget configuration route.
  static const String widgetConfig = '/widget-config';

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

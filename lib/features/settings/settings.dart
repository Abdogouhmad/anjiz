/// Settings feature: the nested settings hub (general, notifications, data and
/// about) plus the home-screen widget configuration.
library;

export 'presentation/providers/accent_tones.dart';
export 'presentation/providers/app_settings.dart';
export 'presentation/providers/settings_controller.dart';
export 'presentation/providers/update_controller.dart';
export 'presentation/providers/update_status.dart';
export 'presentation/screens/about_screen.dart' show AboutScreen;
export 'presentation/screens/data_settings_screen.dart' show DataSettingsScreen;
export 'presentation/screens/general_settings_screen.dart'
    show GeneralSettingsScreen;
export 'presentation/screens/motion_settings_screen.dart'
    show MotionSettingsScreen;
export 'presentation/screens/notifications_settings_screen.dart'
    show NotificationsSettingsScreen;
export 'presentation/screens/settings_screen.dart' show SettingsScreen;
export 'presentation/screens/theme_settings_screen.dart'
    show ThemeSettingsScreen;
export 'presentation/screens/update_screen.dart' show UpdateScreen;
export 'presentation/screens/widget_config_screen.dart' show WidgetConfigScreen;
export 'settings_routes.dart' show settingsRoutes;

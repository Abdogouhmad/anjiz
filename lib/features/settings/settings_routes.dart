import 'package:go_router/go_router.dart';

import 'presentation/screens/about_screen.dart';
import 'presentation/screens/data_settings_screen.dart';
import 'presentation/screens/general_settings_screen.dart';
import 'presentation/screens/motion_settings_screen.dart';
import 'presentation/screens/notifications_settings_screen.dart';
import 'presentation/screens/profile_screen.dart';
import 'presentation/screens/theme_settings_screen.dart';
import 'presentation/screens/update_screen.dart';
import 'presentation/screens/widget_config_screen.dart';

/// The nested settings routes, mounted under the `/settings` branch route.
///
/// General carries its own children so the hub, the section and the leaf screen
/// form a single pop stack.
List<RouteBase> settingsRoutes() => [
  GoRoute(path: 'profile', builder: (context, state) => const ProfileScreen()),
  GoRoute(
    path: 'general',
    builder: (context, state) => const GeneralSettingsScreen(),
    routes: [
      GoRoute(
        path: 'theme',
        builder: (context, state) => const ThemeSettingsScreen(),
      ),
      GoRoute(
        path: 'motion',
        builder: (context, state) => const MotionSettingsScreen(),
      ),
    ],
  ),
  GoRoute(
    path: 'notifications',
    builder: (context, state) => const NotificationsSettingsScreen(),
  ),
  GoRoute(
    path: 'widgets',
    builder: (context, state) => const WidgetConfigScreen(),
  ),
  GoRoute(
    path: 'data',
    builder: (context, state) => const DataSettingsScreen(),
  ),
  GoRoute(path: 'about', builder: (context, state) => const AboutScreen()),
  GoRoute(path: 'update', builder: (context, state) => const UpdateScreen()),
];

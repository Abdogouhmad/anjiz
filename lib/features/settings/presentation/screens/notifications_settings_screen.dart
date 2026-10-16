import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/notifications_sections.dart';
import '../widgets/settings_sub_screen.dart';

/// Notification and home-screen widget settings.
class NotificationsSettingsScreen extends StatelessWidget {
  /// Creates the notifications section screen.
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SettingsSubScreen(
      title: l10n.notificationsAndWidgetsTitle,
      subtitle: l10n.settingsNotificationsSubtitle,
      children: [
        NotificationsSections(
          // Push rather than go so the back button returns to this section.
          onOpenWidgetConfig: () => context.push(AppRoutes.settingsWidgets),
        ),
      ],
    );
  }
}

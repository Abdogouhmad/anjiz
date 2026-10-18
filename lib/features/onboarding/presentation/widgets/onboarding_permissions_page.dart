import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_providers.dart';
import '../../../../l10n/app_localizations.dart';

import 'permission_card.dart';

/// The onboarding step that requests notification and exact-alarm access.
///
/// Both are optional: the app works without them, and they can be granted
/// later from Settings → Notifications.
class OnboardingPermissionsPage extends ConsumerStatefulWidget {
  /// Creates the permissions step.
  const OnboardingPermissionsPage({super.key});

  @override
  ConsumerState<OnboardingPermissionsPage> createState() =>
      _OnboardingPermissionsPageState();
}

class _OnboardingPermissionsPageState
    extends ConsumerState<OnboardingPermissionsPage> {
  bool? _notificationsGranted;
  bool? _exactAlarmsAllowed;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    final service = ref.read(notificationServiceProvider);
    final notifications = await service.areNotificationsEnabled();
    final exact = await service.canScheduleExactAlarms();
    if (mounted) {
      setState(() {
        _notificationsGranted = notifications;
        _exactAlarmsAllowed = exact;
      });
    }
  }

  Future<void> _requestNotifications() async {
    final granted = await ref
        .read(notificationServiceProvider)
        .requestPermission();
    if (mounted) setState(() => _notificationsGranted = granted);
  }

  Future<void> _requestExactAlarms() async {
    final allowed = await ref
        .read(notificationServiceProvider)
        .requestExactAlarmPermission();
    if (mounted) setState(() => _exactAlarmsAllowed = allowed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.only(
        top: AnjizSpacing.lg,
        start: AnjizSpacing.lg,
        end: AnjizSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.onboardingPermissionsTitle,
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: AnjizSpacing.md12),
          Text(
            l10n.onboardingPermissionsMessage,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AnjizSpacing.xl),
          PermissionCard(
            icon: Icons.notifications_active_outlined,
            title: l10n.notificationsPermissionTitle,
            subtitle: l10n.onboardingPermissionNotifications,
            granted: _notificationsGranted,
            onRequest: _requestNotifications,
          ),
          const SizedBox(height: AnjizSpacing.md),
          PermissionCard(
            icon: Icons.alarm_rounded,
            title: l10n.onboardingExactAlarmTitle,
            subtitle: l10n.onboardingPermissionExactAlarms,
            granted: _exactAlarmsAllowed,
            onRequest: _requestExactAlarms,
          ),
        ],
      ),
    );
  }
}

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../onboarding/presentation/widgets/permission_card.dart';

/// Verifies (and requests) notification + exact-alarm access.
///
/// Reuses [PermissionCard] from onboarding so the two flows stay in sync.
class NotificationPermissionSection extends ConsumerStatefulWidget {
  /// Creates the permission section.
  const NotificationPermissionSection({super.key});

  @override
  ConsumerState<NotificationPermissionSection> createState() =>
      _NotificationPermissionSectionState();
}

class _NotificationPermissionSectionState
    extends ConsumerState<NotificationPermissionSection> {
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
    final allGranted =
        (_notificationsGranted ?? false) && (_exactAlarmsAllowed ?? true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnjizSectionHeader(
          title: l10n.notificationsPermissionTitle,
          trailing: AnjizTagPill(
            label: allGranted
                ? l10n.notificationsPermissionGranted
                : l10n.notificationsPermissionDenied,
            tone: allGranted ? AnjizTone.primary : AnjizTone.error,
            icon: allGranted
                ? Icons.check_circle_rounded
                : Icons.error_outline_rounded,
            compact: true,
          ),
        ),
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
    );
  }
}

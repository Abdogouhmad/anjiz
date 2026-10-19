import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/pomodoro_providers.dart';
import '../../domain/pomodoro_availability.dart';

/// Explains why the focus timer is unavailable and, when the only missing
/// piece is notification permission, offers to grant it.
///
/// Springs open when the unavailability resolves and springs shut (keeping the
/// last message visible until settled) once it is fixed.
class FocusAvailabilityHint extends ConsumerStatefulWidget {
  /// Creates the hint for [availability].
  const FocusAvailabilityHint({required this.availability, super.key});

  /// Native capability snapshot; null while it is still being resolved.
  final PomodoroAvailability? availability;

  @override
  ConsumerState<FocusAvailabilityHint> createState() =>
      _FocusAvailabilityHintState();
}

class _FocusAvailabilityHintState extends ConsumerState<FocusAvailabilityHint> {
  /// Last unavailable snapshot, kept so the collapse animates real content.
  PomodoroAvailability? _lastUnavailable;

  @override
  void didUpdateWidget(covariant FocusAvailabilityHint oldWidget) {
    super.didUpdateWidget(oldWidget);
    final state = widget.availability;
    if (state != null && !state.isAvailable) _lastUnavailable = state;
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.availability;
    if (state != null && !state.isAvailable) _lastUnavailable = state;
    final visible = state != null && !state.isAvailable;
    return SpringCollapse(
      collapsed: !visible,
      onCollapsed: () {
        if (mounted) setState(() => _lastUnavailable = null);
      },
      child: _lastUnavailable == null
          ? const SizedBox.shrink()
          : _content(_lastUnavailable!),
    );
  }

  Widget _content(PomodoroAvailability state) {
    final l10n = AppLocalizations.of(context);
    if (!state.platformSupported) {
      return _Hint(message: l10n.pomodoroUnsupported);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Hint(message: l10n.pomodoroPromotedDisabled),
        const SizedBox(height: AnjizSpacing.xs),
        AnjizButton(
          label: l10n.notificationsGrantAction,
          icon: Icons.notifications_active_outlined,
          variant: AnjizButtonVariant.text,
          size: AnjizButtonSize.small,
          onPressed: () async {
            final granted = await ref
                .read(notificationServiceProvider)
                .requestPermission();
            if (granted) ref.invalidate(pomodoroAvailabilityProvider);
          },
        ),
      ],
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AnjizSpacing.sm),
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodySmall
            ?.copyWith(color: scheme.onSurfaceVariant),
      ),
    );
  }
}

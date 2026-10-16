import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/app_info.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/update_status.dart';

/// Card displaying detailed version information and update check metadata,
/// inspired by Walt's OTA update center.
class UpdateVersionCard extends StatelessWidget {
  /// Creates the update version card.
  const UpdateVersionCard({required this.status, this.lastChecked, super.key});

  /// Current update status.
  final UpdateStatus status;

  /// Timestamp of the last successful check.
  final DateTime? lastChecked;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final latestName = status.manifest?.latestVersionName ?? AppInfo.version;

    return AnjizCard(
      padding: const EdgeInsets.all(AnjizSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const AnjizIconBadge(
                icon: Icons.smartphone_rounded,
                tone: AnjizTone.primary,
                size: 36,
                iconSize: 18,
              ),
              const SizedBox(width: AnjizSpacing.md12),
              Text(l10n.updateDetailsTitle, style: textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: AnjizSpacing.md),
          _detailRow(
            icon: Icons.layers_rounded,
            label: l10n.updateInstalledVersion(AppInfo.version),
            value: 'v${AppInfo.version}',
            context: context,
          ),
          _divider(scheme),
          _detailRow(
            icon: Icons.new_releases_outlined,
            label: l10n.updateLatestVersionLabel,
            value: 'v$latestName',
            highlight: status.hasUpdate,
            context: context,
          ),
          _divider(scheme),
          _detailRow(
            icon: Icons.insert_drive_file_outlined,
            label: l10n.updateInstallType,
            value: l10n.updateInstallTypeValue,
            context: context,
          ),
          _divider(scheme),
          _detailRow(
            icon: Icons.schedule_rounded,
            label: l10n.updateLastChecked,
            value: _formatLastChecked(l10n, lastChecked),
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _divider(ColorScheme scheme) =>
      Divider(height: 1, color: scheme.outlineVariant.withValues(alpha: 0.5));

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
    bool highlight = false,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AnjizSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: scheme.onSurfaceVariant),
          const SizedBox(width: AnjizSpacing.md12),
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: AnjizSpacing.md12),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: highlight ? scheme.primary : scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  String _formatLastChecked(AppLocalizations l10n, DateTime? last) {
    if (last == null) return l10n.updateNever;
    final diff = DateTime.now().difference(last);
    if (diff.inSeconds < 60) return l10n.updateJustNow;
    if (diff.inMinutes < 60) return l10n.updateMinutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10n.updateHoursAgo(diff.inHours);
    return '${last.day}/${last.month}/${last.year}';
  }
}

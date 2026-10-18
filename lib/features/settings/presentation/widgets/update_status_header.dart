import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/update_failure.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/update_status.dart';

/// Hero status header inspired by Walt's OTA update center:
/// concentric circles with a status icon and an informative pill.
class UpdateStatusHeader extends StatelessWidget {
  /// Creates the update status header.
  const UpdateStatusHeader({required this.status, super.key});

  /// Current update status.
  final UpdateStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    final failed = status is UpdateStatusFailed;
    final available = status.hasUpdate;
    final checking = status is UpdateStatusChecking;

    final accentBg = failed
        ? scheme.errorContainer
        : checking
        ? scheme.secondaryContainer
        : available
        ? scheme.primaryContainer
        : scheme.secondaryContainer;

    final accentFg = failed
        ? scheme.onErrorContainer
        : checking
        ? scheme.onSecondaryContainer
        : available
        ? scheme.onPrimaryContainer
        : scheme.onSecondaryContainer;

    final icon = checking
        ? Icons.sync_rounded
        : failed
        ? Icons.error_outline_rounded
        : available
        ? Icons.system_update_alt_rounded
        : Icons.check_circle_outline_rounded;

    final (label, tone) = switch (status) {
      UpdateStatusChecking() => (l10n.updateChecking, AnjizTone.secondary),
      UpdateStatusFailed(:final reason) => (
        _failureLabel(l10n, reason),
        AnjizTone.error,
      ),
      UpdateStatusAvailable() ||
      UpdateStatusDownloading() ||
      UpdateStatusInstalling() => (
        l10n.updateAvailableBadge,
        AnjizTone.primary,
      ),
      UpdateStatusIdle() ||
      UpdateStatusCurrent() => (l10n.updateUpToDate, AnjizTone.primary),
    };

    final title = switch (status) {
      UpdateStatusChecking() => l10n.updateChecking,
      UpdateStatusFailed(:final reason) => _failureLabel(l10n, reason),
      UpdateStatusAvailable(:final manifest) => l10n.updateAvailableTitle(
        manifest.latestVersionName,
      ),
      UpdateStatusDownloading(:final manifest) => l10n.updateAvailableTitle(
        manifest.latestVersionName,
      ),
      UpdateStatusInstalling(:final manifest) => l10n.updateAvailableTitle(
        manifest.latestVersionName,
      ),
      UpdateStatusIdle() || UpdateStatusCurrent() => l10n.updateCurrentTitle,
    };

    return Column(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 104,
                  height: 104,
                  decoration: BoxDecoration(
                    color: accentBg.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: accentBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 40, color: accentFg),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AnjizSpacing.md),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AnjizSpacing.xs),
        AnjizTagPill(label: label, tone: tone, icon: icon),
      ],
    );
  }

  static String _failureLabel(AppLocalizations l10n, UpdateFailure reason) =>
      switch (reason) {
        UpdateFailure.network => l10n.updateErrorNetwork,
        UpdateFailure.malformed => l10n.updateErrorMalformed,
        UpdateFailure.unsupported => l10n.updateErrorUnsupported,
        UpdateFailure.permission => l10n.updateErrorPermission,
        UpdateFailure.checksum => l10n.updateErrorChecksum,
        UpdateFailure.download => l10n.updateErrorDownload,
        UpdateFailure.install => l10n.updateErrorInstall,
        UpdateFailure.cancelled => l10n.updateErrorCancelled,
        UpdateFailure.unexpected => l10n.updateErrorUnknown,
      };
}

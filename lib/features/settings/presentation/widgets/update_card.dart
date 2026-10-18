import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/preferences_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/update_controller.dart';
import '../providers/update_status.dart';
import 'update_status_header.dart';
import 'update_version_card.dart';

/// The redesigned update card inspired by Walt's OTA center,
/// combining hero status rings, version details, and CTA action.
class UpdateCard extends ConsumerWidget {
  /// Creates the update card.
  const UpdateCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final status = ref.watch(updateControllerProvider);
    final controller = ref.read(updateControllerProvider.notifier);
    final prefs = ref.watch(sharedPreferencesProvider);
    final lastCheckMillis = prefs.getInt(AppConstants.prefUpdateLastCheck);
    final lastChecked = lastCheckMillis == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(lastCheckMillis);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UpdateStatusHeader(status: status),
        const SizedBox(height: AnjizSpacing.md),
        if (status is UpdateStatusDownloading) ...[
          _DownloadProgress(progress: status.progress),
          const SizedBox(height: AnjizSpacing.md),
        ],
        UpdateVersionCard(status: status, lastChecked: lastChecked),
        const SizedBox(height: AnjizSpacing.md),
        _buildAction(context, l10n, status, controller),
      ],
    );
  }

  Widget _buildAction(
    BuildContext context,
    AppLocalizations l10n,
    UpdateStatus status,
    UpdateController controller,
  ) {
    return switch (status) {
      UpdateStatusChecking() => AnjizLoader(label: l10n.updateChecking),
      UpdateStatusDownloading() => const SizedBox.shrink(),
      UpdateStatusInstalling() => AnjizLoader(
        label: l10n.updateInstallingTitle,
      ),
      UpdateStatusAvailable() => AnjizButton(
        label: l10n.updateInstallAction,
        icon: Icons.download_rounded,
        variant: AnjizButtonVariant.filled,
        expand: true,
        onPressed: controller.install,
      ),
      UpdateStatusFailed() => AnjizButton(
        label: l10n.updateRetryAction,
        icon: Icons.refresh_rounded,
        variant: AnjizButtonVariant.filled,
        expand: true,
        onPressed: controller.check,
      ),
      UpdateStatusIdle() || UpdateStatusCurrent() => AnjizButton(
        label: l10n.updateCheckAgainAction,
        icon: Icons.refresh_rounded,
        variant: AnjizButtonVariant.tonal,
        expand: true,
        onPressed: controller.check,
      ),
    };
  }
}

class _DownloadProgress extends StatelessWidget {
  const _DownloadProgress({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final percent = (progress * 100).clamp(0, 100).round();

    return AnjizCard(
      padding: const EdgeInsets.all(AnjizSpacing.md12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.updateDownloadingLabel(percent),
                style: textTheme.titleSmall,
              ),
              Text(
                '$percent%',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: scheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.sm),
          AnjizWavyProgress(value: progress),
        ],
      ),
    );
  }
}

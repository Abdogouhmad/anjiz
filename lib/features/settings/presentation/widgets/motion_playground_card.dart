import 'dart:math' as math;

import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/haptic_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/settings_controller.dart';

/// Interactive playground allowing the user to experience the scalloped morphing
/// animation, kinetic bursts and tactile haptics in real time.
class MotionPlaygroundCard extends ConsumerStatefulWidget {
  /// Creates the motion playground card.
  const MotionPlaygroundCard({super.key});

  @override
  ConsumerState<MotionPlaygroundCard> createState() =>
      _MotionPlaygroundCardState();
}

class _MotionPlaygroundCardState extends ConsumerState<MotionPlaygroundCard>
    with SingleTickerProviderStateMixin {
  bool _completed = false;
  late final AnimationController _burstController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  );

  @override
  void dispose() {
    _burstController.dispose();
    super.dispose();
  }

  void _handleToggle(bool value) {
    final settings = ref.read(settingsControllerProvider);
    final haptics = ref.read(hapticServiceProvider);
    setState(() => _completed = value);

    if (value) {
      haptics.success();
      if (settings.burstAnimations) {
        _burstController.forward(from: 0);
      }
    } else {
      haptics.selection();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final settings = ref.watch(settingsControllerProvider);

    return AnjizCard(
      elevated: true,
      padding: const EdgeInsets.all(AnjizSpacing.md20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const AnjizIconBadge(
                icon: Icons.auto_awesome_rounded,
                tone: AnjizTone.secondary,
                size: 36,
                iconSize: 18,
              ),
              const SizedBox(width: AnjizSpacing.md12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.motionPlaygroundTitle,
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      l10n.motionPlaygroundSubtitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.md),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AnjizShapes.large),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => _handleToggle(!_completed),
                  child: Padding(
                    padding: const EdgeInsets.all(AnjizSpacing.md12),
                    child: Row(
                      children: [
                        AnjizTaskCheckbox(
                          value: _completed,
                          onChanged: _handleToggle,
                        ),
                        const SizedBox(width: AnjizSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.motionDemoTask,
                                style: textTheme.bodyLarge?.copyWith(
                                  decoration: _completed
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: _completed
                                      ? scheme.onSurfaceVariant
                                      : scheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                l10n.motionDemoSubtitle,
                                style: textTheme.bodySmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnjizTagPill(
                          label: l10n.tagDelight,
                          tone: AnjizTone.primary,
                          compact: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (settings.burstAnimations)
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedBuilder(
                      animation: _burstController,
                      builder: (context, _) => CustomPaint(
                        painter: _BurstPainter(
                          progress: _burstController.value,
                          color: scheme.primary,
                          secondaryColor: scheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AnjizSpacing.md),
          AnjizButton(
            label: l10n.motionTestHaptics,
            icon: Icons.vibration_rounded,
            variant: AnjizButtonVariant.tonal,
            onPressed: () => ref.read(hapticServiceProvider).success(),
          ),
        ],
      ),
    );
  }
}

class _BurstPainter extends CustomPainter {
  _BurstPainter({
    required this.progress,
    required this.color,
    required this.secondaryColor,
  });

  final double progress;
  final Color color;
  final Color secondaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1) return;
    final center = Offset(36, size.height / 2);
    const count = 8;
    final maxRadius = 32.0 * Curves.easeOutCubic.transform(progress);
    final opacity = (1.0 - progress).clamp(0.0, 1.0);

    for (var i = 0; i < count; i++) {
      final angle = (i * 2 * math.pi) / count;
      final dx = center.dx + math.cos(angle) * maxRadius;
      final dy = center.dy + math.sin(angle) * maxRadius;
      final particlePaint = Paint()
        ..color = (i.isEven ? color : secondaryColor).withValues(alpha: opacity)
        ..style = PaintingStyle.fill;
      final particleRadius = (1.0 - progress * 0.7) * 3.5;
      canvas.drawCircle(Offset(dx, dy), particleRadius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(_BurstPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

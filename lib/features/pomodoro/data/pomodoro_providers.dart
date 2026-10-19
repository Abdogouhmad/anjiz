import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/pomodoro_availability.dart';
import 'pomodoro_channel.dart';

part 'pomodoro_providers.g.dart';

/// Provides the singleton [PomodoroChannel], attached and listening for
/// native events for the lifetime of the app.
@Riverpod(keepAlive: true)
PomodoroChannel pomodoroChannel(Ref ref) {
  final channel = PomodoroChannel();
  channel.attach();
  ref.onDispose(channel.dispose);
  return channel;
}

/// What this device can do with the focus timer.
///
/// Never throws: a missing native plugin (desktop, tests) reads as
/// [PomodoroAvailability.unsupported] so the UI can degrade quietly.
@Riverpod(keepAlive: true)
Future<PomodoroAvailability> pomodoroAvailability(Ref ref) async {
  final channel = ref.watch(pomodoroChannelProvider);
  try {
    final sdk = await channel.sdkVersion();
    final canPromote = await channel.canPostPromoted();
    return PomodoroAvailability(
      platformSupported: sdk >= 36,
      canPromote: canPromote,
    );
  } on MissingPluginException {
    return PomodoroAvailability.unsupported;
  } on PlatformException {
    return PomodoroAvailability.unsupported;
  }
}

/// Whether the focus timer can be started on this device right now.
///
/// False while the native capability check is still in flight, so entry points
/// render disabled rather than flashing an enabled control.
@Riverpod(keepAlive: true)
bool pomodoroSupported(Ref ref) =>
    ref.watch(pomodoroAvailabilityProvider).value?.isAvailable ?? false;

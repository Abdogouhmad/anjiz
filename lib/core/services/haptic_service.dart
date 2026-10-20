import 'package:anjiz_ui/anjiz_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_constants.dart';
import 'preferences_provider.dart';

part 'haptic_service.g.dart';

/// The persisted haptic intensity (0 off, 1 subtle, 2 expressive).
///
/// Read synchronously from [sharedPreferencesProvider] so the level is known
/// before the first frame; invalidate after writing the preference.
@Riverpod(keepAlive: true)
int hapticLevel(Ref ref) =>
    ref.watch(sharedPreferencesProvider).getInt(AppConstants.prefHapticLevel) ??
    2;

/// Semantic haptic feedback driven by the persisted [hapticLevelProvider].
///
/// The level is re-read on every call, so a settings change applies as soon as
/// [hapticLevelProvider] is invalidated. Shared components in `anjiz_ui` call
/// `AnjizHaptics` directly; feature code (settings previews, Pomodoro) goes
/// through this service so the setting stays the single source of truth.
class HapticService {
  /// Creates the service reading the level through [ref].
  const HapticService(this._ref);

  final Ref _ref;

  void _sync() => AnjizHaptics.configure(_ref.read(hapticLevelProvider));

  /// Light tap for buttons, FABs and swipe actions.
  void tap() {
    _sync();
    AnjizHaptics.tap();
  }

  /// Selection click for switches, chips and navigation items.
  void selection() {
    _sync();
    AnjizHaptics.selection();
  }

  /// Celebratory feedback on task completion.
  void success() {
    _sync();
    AnjizHaptics.success();
  }

  /// Attention feedback for warnings and destructive confirmations.
  void warning() {
    _sync();
    AnjizHaptics.warning();
  }

  /// Strong feedback for long press and reorder start.
  void heavy() {
    _sync();
    AnjizHaptics.heavy();
  }
}

/// Provides the app-wide [HapticService].
///
/// Read once during bootstrap so the component-level `AnjizHaptics` facade is
/// configured with the persisted level before the first interactive frame.
@Riverpod(keepAlive: true)
HapticService hapticService(Ref ref) {
  AnjizHaptics.configure(ref.read(hapticLevelProvider));
  return HapticService(ref);
}

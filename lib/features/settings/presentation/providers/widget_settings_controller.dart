import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/preferences_provider.dart';
import '../../../../core/services/service_providers.dart';

part 'widget_settings_controller.g.dart';

/// Persisted configuration for the Android home-screen widgets.
class WidgetSettings {
  /// Creates a widget-settings value.
  const WidgetSettings({
    required this.listId,
    required this.showCompleted,
    required this.opacity,
  });

  /// The list shown in the Tasks Overview widget (`null` means every list).
  final String? listId;

  /// Whether completed tasks are listed.
  final bool showCompleted;

  /// Background opacity applied to the widget surfaces.
  final double opacity;

  /// Returns a copy with the provided overrides applied.
  WidgetSettings copyWith({
    String? listId,
    bool clearList = false,
    bool? showCompleted,
    double? opacity,
  }) {
    return WidgetSettings(
      listId: clearList ? null : (listId ?? this.listId),
      showCompleted: showCompleted ?? this.showCompleted,
      opacity: opacity ?? this.opacity,
    );
  }
}

/// Owns the persisted widget configuration read from shared preferences.
@Riverpod(keepAlive: true)
class WidgetSettingsController extends _$WidgetSettingsController {
  @override
  WidgetSettings build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return WidgetSettings(
      listId: prefs.getString(AppConstants.prefWidgetListId),
      showCompleted:
          prefs.getBool(AppConstants.prefWidgetShowCompleted) ?? false,
      opacity: prefs.getDouble(AppConstants.prefWidgetOpacity) ?? 1,
    );
  }

  /// Selects the list shown in the widgets.
  Future<void> setListId(String? listId) async {
    state = listId == null
        ? state.copyWith(clearList: true)
        : state.copyWith(listId: listId);
    final prefs = ref.read(sharedPreferencesProvider);
    if (listId == null) {
      await prefs.remove(AppConstants.prefWidgetListId);
    } else {
      await prefs.setString(AppConstants.prefWidgetListId, listId);
    }
    await _syncWidgets();
  }

  /// Toggles whether completed tasks appear in the widgets.
  Future<void> setShowCompleted({required bool enabled}) async {
    state = state.copyWith(showCompleted: enabled);
    await ref
        .read(sharedPreferencesProvider)
        .setBool(AppConstants.prefWidgetShowCompleted, enabled);
    await _syncWidgets();
  }

  /// Sets the widget background opacity.
  Future<void> setOpacity(double value) async {
    state = state.copyWith(opacity: value);
    await ref
        .read(sharedPreferencesProvider)
        .setDouble(AppConstants.prefWidgetOpacity, value);
    await _syncWidgets();
  }

  Future<void> _syncWidgets() => ref.read(widgetSyncServiceProvider).sync();
}

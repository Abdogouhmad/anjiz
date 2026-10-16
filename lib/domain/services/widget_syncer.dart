/// Port for pushing the latest task snapshot to the home-screen widgets.
///
/// Implemented in `core/services`; use cases depend only on this abstraction so
/// the domain layer stays free of Flutter/plugin imports.
abstract interface class WidgetSyncer {
  /// Pushes the current snapshot and refreshes every registered widget.
  Future<void> sync();
}

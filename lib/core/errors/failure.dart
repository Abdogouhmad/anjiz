/// Categories of recoverable failures surfaced to the presentation layer.
enum FailureKind {
  /// A local database (drift) error.
  database,

  /// A notification scheduling/platform error.
  notification,

  /// A home-screen widget sync error.
  widgetSync,

  /// Invalid user input or an illegal state transition.
  validation,

  /// Anything else.
  unexpected,
}

/// A typed, user-mappable failure. The `message` is a diagnostic string for
/// logs; user-facing copy is resolved from l10n by the presentation layer.
class Failure implements Exception {
  /// Creates a failure.
  const Failure(this.kind, this.message, {this.cause});

  /// Creates a validation failure.
  const Failure.validation(this.message)
    : kind = FailureKind.validation,
      cause = null;

  /// The failure category.
  final FailureKind kind;

  /// Diagnostic message (not necessarily user-facing).
  final String message;

  /// The underlying error, when available.
  final Object? cause;

  @override
  String toString() => 'Failure(${kind.name}): $message';
}

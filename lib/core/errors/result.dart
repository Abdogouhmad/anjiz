import 'failure.dart';

/// A minimal operation result: either a [value] or a [Failure].
///
/// Kept as a single class (rather than a sealed hierarchy) so the whole concept
/// lives in one small file; use [when] to branch.
class Result<T> {
  /// A successful result carrying [value].
  const Result.ok(this.value) : failure = null;

  /// A failed result carrying [failure].
  const Result.err(this.failure) : value = null;

  /// The success value, or null.
  final T? value;

  /// The failure, or null.
  final Failure? failure;

  /// Whether this result is a success.
  bool get isOk => failure == null;

  /// The value, throwing [StateError] when this is a failure.
  T get requireValue {
    final failure = this.failure;
    if (failure != null) throw StateError('Result failure: $failure');
    return value as T;
  }

  /// Branches on success/failure.
  R when<R>({
    required R Function(T value) ok,
    required R Function(Failure failure) err,
  }) {
    final failure = this.failure;
    if (failure != null) return err(failure);
    return ok(value as T);
  }
}

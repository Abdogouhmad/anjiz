import 'dart:math';

/// Generates collision-resistant identifiers for entities.
///
/// Uses a random 128-bit value rendered as a hex string; suitable for a
/// single-device, offline-first store.
abstract final class IdGenerator {
  static final Random _random = Random.secure();

  /// Returns a new 32-character hex id.
  static String newId() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    final buffer = StringBuffer();
    for (final byte in bytes) {
      buffer.write(byte.toRadixString(16).padLeft(2, '0'));
    }
    return buffer.toString();
  }

  /// Returns a deterministic-ish numeric notification id derived from [seed].
  static int notificationIdFor(String seed) {
    var hash = 0;
    for (final code in seed.codeUnits) {
      hash = 0x1fffffff & (hash * 31 + code);
    }
    return hash;
  }
}

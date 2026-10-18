import '../../../../l10n/app_localizations.dart';

/// Seed colours offered by the Accent Tone setting, in display order.
///
/// Index 0 is the built-in Emerald palette; the rest are custom seeds.
const List<int> kAccentSeeds = <int>[
  0xFF1B7A66, // Emerald (built-in)
  0xFF1B5E7A, // Ocean
  0xFF4F5BBA, // Indigo
  0xFF7E4E90, // Violet
  0xFFB83B5E, // Rose
  0xFF9C4125, // Terracotta
  0xFFB26A00, // Amber
  0xFF00796B, // Teal
  0xFF5B527E, // Lavender
  0xFF826117, // Sand
];

/// Localised display name for the accent at [index].
String accentLabel(AppLocalizations l10n, int index) => switch (index) {
  0 => l10n.accentEmerald,
  1 => l10n.accentOcean,
  2 => l10n.accentIndigo,
  3 => l10n.accentViolet,
  4 => l10n.accentRose,
  5 => l10n.accentTerracotta,
  6 => l10n.accentAmber,
  7 => l10n.accentTeal,
  8 => l10n.accentLavender,
  _ => l10n.accentSand,
};

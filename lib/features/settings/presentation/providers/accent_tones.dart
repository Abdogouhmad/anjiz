import '../../../../l10n/app_localizations.dart';

/// Seed colours offered by the Accent Tone setting, in display order.
///
/// Index 0 is the built-in Emerald palette; the rest are custom seeds.
const List<int> kAccentSeeds = <int>[
  0xFF1B7A66, // Emerald (built-in)
  0xFF1B5E7A, // Ocean
  0xFF9C4125, // Terracotta
  0xFF5B527E, // Lavender
  0xFF826117, // Sand
];

/// Localised display name for the accent at [index].
String accentLabel(AppLocalizations l10n, int index) => switch (index) {
  0 => l10n.accentEmerald,
  1 => l10n.accentOcean,
  2 => l10n.accentTerracotta,
  3 => l10n.accentLavender,
  _ => l10n.accentSand,
};

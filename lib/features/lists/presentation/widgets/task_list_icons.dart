import 'package:flutter/material.dart';

/// Icon names persisted on [TaskList]s, mapped to their Material glyphs.
///
/// List icons are stored as stable strings so the data layer stays free of
/// Flutter types; this is the single place that resolves them.
const Map<String, IconData> kTaskListIcons = <String, IconData>{
  'inbox': Icons.inbox_rounded,
  'work': Icons.work_outline_rounded,
  'personal': Icons.spa_outlined,
  'design': Icons.palette_outlined,
  'health': Icons.favorite_border_rounded,
  'study': Icons.menu_book_outlined,
  'home': Icons.home_outlined,
  'shopping': Icons.shopping_basket_outlined,
  'travel': Icons.flight_takeoff_rounded,
  'finance': Icons.savings_outlined,
};

/// Icon choices offered by the create-list sheet, in display order.
const List<String> kTaskListIconChoices = <String>[
  'inbox',
  'work',
  'personal',
  'design',
  'health',
  'study',
  'home',
  'shopping',
];

/// Resolves a persisted [name] to an icon, defaulting to a folder.
IconData taskListIcon(String name) =>
    kTaskListIcons[name] ?? Icons.folder_outlined;

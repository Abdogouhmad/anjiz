# Changelog

All notable changes to Anjiz are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-10-16

The first release: an offline-first Material 3 Expressive to-do app with Android
home-screen widgets.

### Added

- **Design system (`packages/anjiz_ui`)**
  - Dynamic-colour Material 3 Expressive theme with the `#1B7A66` seed fallback,
    light and dark schemes, and RTL-safe tokens.
  - Tokens for spacing, shapes, elevation and spring motion (`AnjizMotion`).
  - Components: scalloped morphing task checkbox, expanding FAB menu, connected
    button group, split button, floating toolbar, wavy linear and ring progress,
    large collapsing app bar, adaptive nav bar/rail, cards, list tiles, swipe
    rows, chips, text fields, search bar, segmented selector, bottom sheets,
    empty/error/loading states, snackbars and settings tiles.
  - Adaptive layouts: nav bar on compact, rail from 600 dp, rail + list/detail
    panes from 840 dp.
- **Domain and data**
  - Pure-Dart entities, repository interfaces, service ports
    (`WidgetSyncer`, `ReminderScheduler`) and use cases for tasks, subtasks,
    lists, ordering, stars and reminders.
  - Drift (SQLite) schema for `task_lists`, `tasks`, `subtasks` and `reminders`
    with DAOs, mappers and repository implementations; "My Tasks" is created on
    first launch.
- **Features** — Today, Upcoming, Lists (with list detail), Task detail,
  Add-task composer, Search, Settings and Onboarding, with English localisation.
- **Reminders** — local notifications scheduled ahead of a task's due time,
  rebuilt after reboot and at day boundaries.
- **Home-screen widgets** — Jetpack Glance tasks-overview (4×4, compact 4×2),
  progress (2×2) and quick-add (4×1) widgets with tap-to-complete, Material You
  colours, RTL support, a configuration screen, and a WorkManager background
  refresh job. `WidgetSyncService` is the single data pusher.
- **App icon** — vector sources with background/foreground/monochrome layers, a
  reproducible rasterise pipeline (`tool/render_icons.sh`) and
  `flutter_launcher_icons` configuration including Android 13+ themed icons.
- **Tooling and docs** — Dart workspace layout, `justfile`, README, this
  changelog and CONTRIBUTING; `flutter analyze` is clean and unit tests pass.

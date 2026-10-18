# Changelog

All notable changes to Anjiz are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Linux desktop target for local UI development (`just run-linux`), with
  `just run-android`, `just devices` and `just emulators` helpers.
- **Pure black (OLED) dark theme**: a new Appearance & Theme switch collapses
  the dark surfaces onto true black
  (`AnjizColorSchemes.pureBlack`, `AnjizTheme.dark(pureBlack: true)`).
- **Floating glass navigation bar** (`AnjizFloatingNavBar`): the compact bottom
  bar now hovers over the content on a translucent, backdrop-blurred pill and
  the shell uses `Scaffold.extendBody` so content scrolls behind it.
- **Nested Settings**: the hub is now a status page — a profile header plus
  sections ("Preferences", "Data", "Other") whose rows name their current value
  ("Dark · Material You", "Daily briefing off", "Anjiz v0.1.0"). Each area opens
  its own screen: General (`/settings/general` → Theme, Motion & haptics),
  Notifications & Widgets (`/settings/notifications` → `/settings/widgets`),
  Data & Backup (`/settings/data`) and About (`/settings/about`). Every nested
  route is a child of the Settings branch, so the hub stays selected in the
  floating nav bar and the whole stack pops back one screen at a time.
- Settings design-system parts: `AnjizSettingsNavGroup`/`AnjizSettingsNavEntry`
  (a card of navigation rows), an optional header on `AnjizSettingsCard` and
  `AnjizSectionHeader` group headings on settings screens.
- **Over-the-air updates**: installed builds check the committed
  `update_manifest.json` (silently, at most once every six hours), post a one-off
  notification when a newer release exists, and Settings → **App update**
  (`/settings/update`) shows the installed version, the release notes from
  `CHANGELOG.md`, download progress, and a **Download and install** action that
  verifies the published sha256 and hands the APK to Android's package installer
  (`UpdateService`, `ota_update`). The permission failure that Android shows the
  first time is explained in-app instead of being a dead end.
- **Release pipeline**: `build.sh` derives the tag/version/versionCode from
  `pubspec.yaml`, builds the split-per-ABI and universal release APKs, signs them
  with the stable keystore, verifies every signature with `apksigner` and stages
  them under `dist/`; `.github/workflows/release.yml` publishes the GitHub
  release, rewrites `update_manifest.json` (URL + sha256 + notes) and commits it
  back to `main`, while `ci.yml` gates pull requests on formatting, analysis,
  both test suites and a debug APK build. The Android `versionCode` is now
  derived as `major*10000 + minor*100 + patch` so the app, the APK and the
  manifest always agree.
- `tool/check_icon_safe_zone.py` (`just icon-check`): fails when a launcher layer
  drifts outside the 66dp safe zone every Android mask guarantees.

### Changed

- **Settings follows a Walt-style layout**: section headers now sit above
  header-less group cards, rows ellipsize to a single line so a group keeps a
  uniform rhythm, and the Theme screen is split into "Brightness" (mode, pure
  black) and "Colour" (dynamic colour, accent tone) groups. Pure black is only
  interactive in dark mode and says "Available in dark mode" otherwise, and the
  widget row now describes what it configures instead of promising glances,
  a quick-add pill and a lock-screen ticker.
- Android-only services (`NotificationService`, `WidgetSyncService`,
  `BackgroundRefreshScheduler`) now degrade to no-ops on unsupported platforms
  via `PlatformSupport` (`lib/core/utils/platform_support.dart`), so the desktop
  build no longer throws `MissingPluginException` at startup. Widgets and
  reminders remain Android-only.
- **Application id renamed** from `com.anjiz` to `com.freesoftware.anjiz`
  (Android `namespace`/`applicationId`, Kotlin packages, the Linux
  `APPLICATION_ID` and `AppConstants.androidWidgetPackage`).
- The Settings subtitle is English (`Your daily achievement`); the app no
  longer ships any Arabic copy.
- Replaced the Material `NavigationBar` (`AnjizNavBar`) with the floating glass
  bar on compact layouts; the four tab screens reserve extra bottom padding via
  `AnjizFloatingNavBar.contentBottomInset`.

### Fixed

- **Launcher icon was clipped on every Android 8+ device**: the render step
  rasterised the foreground and monochrome layers from the middle 72dp of the
  108dp canvas, zooming the glyph 1.5×. It reached 44.8dp from the centre — well
  past the 33dp safe-zone radius — so a circular mask cut the scalloped cookie
  off completely (the icon collapsed to a plain disc) and a Pixel's squircle
  chopped its edges flat. The layers now render the full canvas (glyph at 29.9dp
  ≈ 83% of the visible 72dp area, matching `assets/icons/preview_masks.png`), and
  `tool/check_icon_safe_zone.py` fails the build tooling if a layer ever drifts
  back outside the safe zone.
- **Lists screen crash**: the stat strip used `CrossAxisAlignment.stretch`
  inside a sliver, where the height is unbounded, so the whole screen failed to
  lay out with `RenderBox was not laid out`. The strip is now wrapped in an
  `IntrinsicHeight`, which also keeps the three pills equal-height at any text
  scale.
- The list-summary card no longer overflows horizontally in a two-column grid:
  the "N tasks remaining" pill ellipsizes, and `AnjizTagPill` keeps its label on
  a single line instead of wrapping or exceeding its slot.
- The list-summary card's progress row ellipsizes too, so it survives 2× text
  scale without a `RenderFlex` overflow.
- Relative due copy no longer doubles the preposition: "Overdue by in 8h" and
  "Due in in 8h" now read "Overdue by 8h" and "Due in 2h". The task-detail due
  row also keeps the real date ("Today • 9:00 AM") and leaves the state to the
  pill, matching the design.
- Removed a stray empty `build-tools/36` directory that shadowed the real
  `build-tools/36.0.0` and made `flutter doctor`/Android builds fail.
- Large collapsing app bar no longer overflows by ~3 px once collapsed (the
  title stack now scales down to fit, including at large text scales).
- `AnjizButton` labels now use the button's resolved foreground colour, so the
  text matches the icon instead of rendering white on a light primary
  container in dark mode.
- The floating nav bar announces a single, non-duplicated semantic label per
  destination.
- The accent-tone swatch row keeps equal-width slots and ellipsizes its labels,
  so a long localised name (or 2× text scale) no longer overflows the row.

## [0.1.1] - 2026-10-18

### Fixed

- **Reminders and the daily briefing never fired on a real device.** The app
  manifest was missing the `flutter_local_notifications` receivers the plugin
  needs to deliver scheduled notifications. `ScheduledNotificationReceiver` is
  the target of the `AlarmManager` alarm, so without it every scheduled
  notification fired into the void; `ScheduledNotificationBootReceiver` restores
  them after a reboot or update; and `ActionBroadcastReceiver` is what dispatches
  notification action buttons. All three are now declared.
- **The reminder "Snooze" action did nothing.** It depends on the same missing
  `ActionBroadcastReceiver`; with the receiver registered, tapping Snooze
  reschedules the reminder 10 minutes out under its original title.
- **Exact reminders on Android 12+/14+.** Added the `USE_EXACT_ALARM` permission
  (granted at install for reminder apps), alongside `SCHEDULE_EXACT_ALARM`, so
  reminders can fire at the precise minute instead of degrading to inexact.
- **Quick-add from the home-screen widget only worked once.** The widget-launch
  stream de-duplicated every tap against the previous deep link, so once the
  quick-add composer had been opened, tapping the same widget again emitted an
  identical URI and was swallowed — the composer never reopened. Taps are now
  passed through as-is, so the composer opens on every tap (cold start and
  warm).

## [0.1.0] - 2026-10-16

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

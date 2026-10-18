# AGENTS.md — Anjiz (أنجِز)

Flutter to-do app, Android first. Material 3 + **M3 Expressive**. Offline-first. Has Android home-screen widgets (like Google Tasks).
Read this file fully before touching code. Follow it strictly.

## 0. Golden rules
1. **Small files.** Target ≤150 lines per file, hard max 250. One public widget/class per file. Split if bigger.
2. **No UI primitives inside features.** Any reusable widget (buttons, cards, rows, sheets, checkbox, chips, empty states, loaders, text fields) lives in `packages/anjiz_ui`. Features only compose them. If a feature needs a new primitive, create it in `anjiz_ui` first.
3. **No hard-coded colors, sizes, radii, durations, strings.** Use theme tokens (`AnjizTheme`, `AnjizShapes`, `AnjizSpacing`, `AnjizMotion`) and l10n.
4. **Dependency direction:** `features → domain ← data`, and everything may use `anjiz_ui` and `core`. `domain` is pure Dart (no Flutter imports). Features never import `data` directly.
5. **Dynamic color first** (`dynamic_color`), fallback seed `#1B7A66`. Light + dark. RTL-safe (use `EdgeInsetsDirectional`, `AlignmentDirectional`).
6. **Before finishing any task:** `dart format .`, `flutter analyze` (zero warnings), run tests.

## 1. Stack
- State: `flutter_riverpod` (+ `riverpod_annotation` / generator)
- Routing: `go_router`
- Local DB: `drift` (SQLite) — single source of truth
- Models: `freezed` + `json_serializable` for entities/DTOs
- Notifications/reminders: `flutter_local_notifications` + `timezone`
- Home widget: `home_widget` + native Android widget (Kotlin, Jetpack Glance with Material 3 dynamic color; fall back to RemoteViews only if Glance blocks a requirement)
- Background refresh: `workmanager` (widget refresh, reminder rescheduling after reboot)
- OTA updates: `ota_update` (download, sha256 verify, hand to Android's installer), `http` (release manifest), `package_info_plus` (installed version/versionCode)
- Theming: `dynamic_color`; for expressive shapes/morphing check pub.dev for a maintained M3 shapes package (e.g. `material_new_shapes`) and Flutter stable's built-in expressive components before writing custom ones. Verify versions on pub.dev; do not guess APIs.
- Tests: `flutter_test`, `mocktail`

## 2. Repository layout

```
anjiz/
├── AGENTS.md
├── pubspec.yaml                  # workspace root (Dart workspaces)
├── analysis_options.yaml
├── build.sh                      # signed release build → dist/
├── update_manifest.json          # the OTA feed the app reads (CI-owned)
├── .github/workflows/            # ci.yml (PR gate) · release.yml (signed release)
├── tool/                         # icon pipeline + safe-zone checker
├── assets/icon/                  # adaptive icon layers
├── android/                      # app + native widget (Kotlin)
│   └── app/src/main/kotlin/.../widget/
├── packages/
│   └── anjiz_ui/                 # SHARED UI PACKAGE (design system)
│       └── lib/
│           ├── anjiz_ui.dart     # barrel export
│           └── src/
│               ├── theme/        # anjiz_theme, color_schemes, typography
│               ├── tokens/       # spacing, shapes, motion, elevation
│               ├── components/
│               │   ├── buttons/       # anjiz_button, anjiz_fab_menu, button_group
│               │   ├── inputs/        # anjiz_text_field, search_bar, date_chip
│               │   ├── lists/         # anjiz_list_tile, swipe_row, section_header
│               │   ├── task/          # task_checkbox (scalloped morph), priority_chip
│               │   ├── feedback/      # empty_state, wavy_progress, snackbar
│               │   ├── sheets/        # anjiz_bottom_sheet, drag_handle
│               │   └── navigation/    # nav_bar, nav_rail, floating_toolbar
│               └── layout/        # adaptive_scaffold, breakpoints
├── lib/
│   ├── main.dart                 # runApp only
│   ├── app/
│   │   ├── app.dart              # MaterialApp.router + theme wiring
│   │   ├── router.dart
│   │   └── bootstrap.dart        # DB, notifications, widget init
│   ├── core/
│   │   ├── constants/
│   │   ├── errors/               # Failure types, Result
│   │   ├── extensions/           # DateTime, String, BuildContext
│   │   ├── utils/
│   │   └── services/             # notification_service, widget_sync_service
│   ├── domain/                   # pure Dart
│   │   ├── entities/             # task, task_list, subtask, reminder
│   │   ├── repositories/         # abstract interfaces
│   │   └── usecases/             # add_task, toggle_task, reorder, ...
│   ├── data/
│   │   ├── database/             # drift tables, DAOs, migrations
│   │   ├── mappers/              # row <-> entity
│   │   └── repositories/         # implementations
│   ├── features/
│   │   ├── today/
│   │   ├── upcoming/
│   │   ├── lists/
│   │   ├── task_detail/
│   │   ├── add_task/
│   │   ├── search/
│   │   ├── settings/
│   │   └── onboarding/
│   │      each feature:
│   │      ├── presentation/
│   │      │   ├── screens/      # *_screen.dart (thin, composes widgets)
│   │      │   ├── widgets/      # feature-only compositions of anjiz_ui
│   │      │   └── providers/    # Riverpod notifiers
│   │      └── <feature>.dart    # barrel
│   └── l10n/                     # arb files (en, ar, fr)
└── test/                         # mirrors lib/
```

## 3. Conventions
- **File naming:** `snake_case.dart`; suffixes `_screen`, `_provider`, `_repository`, `_dao`, `_entity`.
- **Screens are thin:** build method composes `anjiz_ui` components + provider state. No business logic, no raw `Container`/`TextStyle` styling.
- **Logic** lives in use cases (domain) and notifiers (presentation). Widgets never touch drift or services directly.
- **Providers:** one provider per file when non-trivial. Expose `AsyncValue`; handle loading/error with shared `anjiz_ui` feedback components.
- **Barrels:** each package/feature exposes one barrel file; import via barrel only.
- **Const everything possible.** Prefer `const` constructors.
- **Comments:** only for non-obvious "why". Public `anjiz_ui` components get a short doc comment.
- **Strings:** all user-visible text in `lib/l10n/*.arb`.
- **Accessibility:** min 48dp targets, semantic labels on icon buttons and checkbox, respect text scale up to 2.0 and reduced-motion.

## 4. M3 Expressive requirements (implement in `anjiz_ui`)
- Scalloped/cookie checkbox that morphs circle → scallop + check on completion (spring motion).
- Expanding FAB menu (Task / List / Voice).
- Connected button group, split button, floating toolbar.
- Wavy progress indicator (linear + circular).
- Large collapsing top app bar with big display title.
- Spring motion tokens in `AnjizMotion` (fast/default/slow spatial + effects springs); all animations use them.
- Adaptive layouts: compact (<600) nav bar; medium (600–840) rail; expanded (≥840) rail + list/detail panes.

## 5. Home widget spec
Native Android widgets, data pushed from Flutter via `home_widget` (shared preferences / JSON snapshot).
- **Tasks Overview (4x4):** list switcher header, "+" add button, up to 6 tasks with tap-to-complete, "+N more", empty state.
- **Compact (4x2):** 3 tasks. **Progress (2x2):** wavy ring "done/total". **Quick add (4x1).**
- Material You dynamic colors; light/dark; RTL.
- Tap-to-complete runs through a background callback (`home_widget` interactivity) → updates DB → refreshes widgets.
- Config activity: choose list, show completed, opacity.
- `WidgetSyncService` (in `core/services`) is the only place that pushes data; call it from use cases after any task mutation.
- Refresh on: task change, midnight rollover, boot (workmanager), timezone change.

## 6. Data model (drift)
- `task_lists(id, name, color, icon, sort_order, created_at)`
- `tasks(id, list_id, title, notes, is_done, is_starred, priority, due_at, has_time, repeat_rule, sort_order, completed_at, created_at, updated_at)`
- `subtasks(id, task_id, title, is_done, sort_order)`
- `reminders(id, task_id, remind_at, notification_id)`
Default list "My Tasks" created on first launch. Soft-delete not required; use undo snackbar.

## 7. App icon
Layers in `assets/icon/`: `ic_background.png`, `ic_foreground.png`, `ic_monochrome.png`, `ic_playstore_512.png` (432x432 adaptive layers on 108dp canvas, safe zone 66dp).
Configure `flutter_launcher_icons`:
```yaml
flutter_launcher_icons:
  android: true
  ios: false
  image_path: assets/icon/ic_playstore_512.png
  adaptive_icon_background: assets/icon/ic_background.png
  adaptive_icon_foreground: assets/icon/ic_foreground.png
  adaptive_icon_monochrome: assets/icon/ic_monochrome.png
```
Verify generated `mipmap-anydpi-v26/ic_launcher.xml` contains `<monochrome>` (Android 13+ themed icon) and that every layer survives the launcher masks: `tool/check_icon_safe_zone.py assets/icon/ic_foreground.png assets/icon/ic_monochrome.png` must report both inside the 33dp safe-zone radius. Keep `minSdk` per Flutter default; legacy PNG mipmaps are generated for older versions.

## 8. Implementation order
1. Workspace + `anjiz_ui` skeleton: tokens, theme (dynamic color), adaptive scaffold.
2. Core `anjiz_ui` components (checkbox, list tile, buttons, sheet, empty state, progress).
3. Domain entities + drift DB + repositories + use cases (with tests).
4. Features: today → add_task → task_detail → lists → upcoming → search → settings → onboarding.
5. Notifications/reminders.
6. Native widgets + `WidgetSyncService` + config screen.
7. Polish: motion, a11y, RTL, tablet layouts, icon.
Work one step at a time; after each, run analyze + tests and summarize what changed.

## 9. Design source
Google Stitch export is in `docs/design/` (screens + `design.md`). Match it; map Stitch components to `anjiz_ui` components 1:1. If the design conflicts with this file's architecture rules, keep the architecture and match visuals.

## 10. Definition of done (per task)
- No file >250 lines; no UI primitive created outside `anjiz_ui`.
- No hard-coded colors/strings; light, dark, RTL checked.
- `flutter analyze` clean, tests pass, new logic covered.

## 11. Releases & OTA updates
- `version:` in `pubspec.yaml` is the single source of truth. The `versionCode` is `major*10000 + minor*100 + patch` and is implemented in **three** places that must stay in sync: `android/app/build.gradle.kts`, `AppInfo.versionCodeOf` (`lib/core/services/app_info.dart`) and `build.sh`.
- Every release APK is signed with the same stable keystore, provisioned from the `ANJIZ_*` secrets. Never ship an unsigned or debug-signed release: Android will not install it, and a changed signature can never update an installed app.
- `update_manifest.json` (repo root) is the feed the app reads at runtime. `release.yml` rewrites and commits it — never commit it by hand, and never point it at an APK that was not built by `build.sh`.
- To release: bump `version:`, add a matching `## [<version>]` section to `CHANGELOG.md`, merge to `main`. `./build.sh --detect-version` must report that version, and `./build.sh --release-notes` must extract the section (it fails loudly when it is missing).
- Background update checks stay silent and rate-limited (`UpdateController.checkInterval`); the user only sees an update through the Settings → App update row, the screen, or a single notification per release.

# Anjiz <sub>(أنجِز)</sub>

An offline-first, **Material 3 Expressive** to-do app for Android — with
home-screen widgets that feel like Google Tasks.

Everything lives on-device (SQLite via Drift); there is no account and no
network. Dynamic colour, spring motion, a scalloped task checkbox and adaptive
layouts (phone → tablet) come from the shared `anjiz_ui` design system.

<p align="left">
  <img src="assets/icons/preview_masks.png" alt="Anjiz icon under launcher masks" width="480">
</p>

## Features

- **Today** — greeting banner plus a focused agenda of due and starred tasks.
- **Upcoming** — a date strip and per-day agenda with a momentum summary.
- **Lists** — colour-coded lists with per-list counts and a daily milestone.
- **Tasks** — due date/time, priority, notes, subtasks, recurrence (repeat
  rule), stars and completion.
- **Reminders** — local notifications scheduled ahead of a task's due time,
  rebuilt after reboot.
- **Search** — full-screen search across titles and notes.
- **Settings** — theme mode, dynamic colour, accent tone, motion/haptics,
  daily briefing, widget configuration, data.
- **Home-screen widgets** — tasks overview (4×4 / compact 4×2), progress
  (2×2) and quick add (4×1), with tap-to-complete and Material You colours.
- **RTL-aware** and light/dark, with an accessible design system.

## Requirements

- Flutter **3.47+** / Dart **3.13+** (Dart workspaces).
- Android toolchain for building: JDK 17, Android SDK (compile SDK from Flutter).
- Optional dev tooling: [`just`](https://github.com/casey/just),
  `python3` + `rsvg-convert` (only for regenerating the icon).

## Getting started

```sh
flutter pub get
just gen          # or: flutter gen-l10n && dart run build_runner build --delete-conflicting-outputs
flutter run
```

`just` wraps the common tasks:

| Command | What it does |
| --- | --- |
| `just pub-get` | `flutter pub get` |
| `just gen` | Regenerate l10n + generated code |
| `just analyze` | `flutter analyze` (must be clean) |
| `just test-all` | App + `anjiz_ui` test suites |
| `just format` | `dart format .` |
| `just icons` | Rasterise icons + regenerate launcher resources |
| `just apk` / `just appbundle` | Build Android artefacts |
| `just check` | Format, analyse and test — the pre-PR gate |

Run `just` on its own to list every recipe.

## Architecture

Layered, offline-first, with a strict dependency direction:

```
features  ──▶  domain  ◀──  data
   │              ▲
   └──────────────┴──  anjiz_ui · core
```

```
lib/
├── app/          # bootstrap, router, shell, DI wiring
├── core/         # constants, errors, extensions, services, utils
├── domain/       # pure Dart: entities, repositories, use cases, service ports
├── data/         # Drift database, DAOs, mappers, repository implementations
├── features/     # today · upcoming · lists · task_detail · add_task
│                 # search · settings · onboarding
└── l10n/         # ARB files (English)
packages/anjiz_ui # shared Material 3 Expressive design system
android/          # app + native Jetpack Glance widgets (Kotlin)
```

Key rules (see [AGENTS.md](AGENTS.md) for the full contract):

- **UI primitives live only in `anjiz_ui`.** Features compose them; they never
  invent new buttons/cards/rows.
- **`domain` is pure Dart** — no Flutter imports. Platform concerns enter
  through ports (`WidgetSyncer`, `ReminderScheduler`).
- **Features never import `data`.** Repository interfaces live in `domain`.
- **No hard-coded colours, sizes or strings** — use `AnjizSpacing`,
  `AnjizShapes`, `AnjizMotion`, theme tokens and l10n.
- **Small files** — target ≤150 lines, hard cap 250.

State is Riverpod; routing is `go_router`; entities are Freezed; persistence is
Drift (single source of truth).

## Home-screen widgets

Native Android widgets are written with **Jetpack Glance** and fed a JSON
snapshot by `WidgetSyncService` — the only component allowed to push widget
data. Widgets in `com.anjiz.widget`:

| Widget | Size | Contents |
| --- | --- | --- |
| `TasksOverviewWidget` | 4×4 (→ 4×2 compact) | List switcher, add button, up to 6 tasks, "+N more", empty state |
| `ProgressWidget` | 2×2 | Determinate progress + `done/total` |
| `QuickAddWidget` | 4×1 | One-tap composer launch |

Tap-to-complete runs in a background isolate
(`lib/app/widget_background.dart`) → updates the database → refreshes every
widget. A WorkManager job (`lib/core/services/background_refresh.dart`)
re-syncs widgets and reschedules reminders after a reboot and at day boundaries.

Colours come from `GlanceTheme`, which maps to `@android:color/system_accent*`
on Android 12+ for Material You; there is no static colour palette to maintain.
Native widget labels live in
`android/app/src/main/res/values/strings.xml` because the widget process cannot
reach Flutter's ARB localisations.

Configure a widget via the in-app **Widget configuration** screen (list,
completed visibility, opacity).

## Icons

Vector sources live in `assets/icons/`; the PNG layers consumed by
`flutter_launcher_icons` are generated by a reproducible script:

```sh
just icons     # tool/render_icons.sh + dart run flutter_launcher_icons
```

See [`assets/icons/README.md`](assets/icons/README.md) for details. The adaptive
icon includes a `<monochrome>` layer for Android 13+ themed icons.

## Testing

```sh
just test-all   # flutter test  +  cd packages/anjiz_ui && flutter test
```

Unit tests cover the domain use cases, mappers and the design-system widgets.
Run `just analyze` — the project is kept at **zero** analyzer issues.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). In short: branch from `main`, keep the
architecture rules above, run `just check`, and update
[CHANGELOG.md](CHANGELOG.md).

## License

See [LICENSE](LICENSE).

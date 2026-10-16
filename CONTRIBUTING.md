# Contributing to Anjiz

Thanks for wanting to help! Anjiz is an offline-first, Material 3 Expressive
to-do app. This guide covers the workflow and the conventions that keep the
codebase consistent.

By participating you agree to be respectful and constructive. Unless stated
otherwise, contributions are licensed under the project's [Apache-2.0
license](LICENSE).

## Prerequisites

- Flutter **3.47+** / Dart **3.13+** (the project uses Dart workspaces).
- JDK 17 + Android SDK if you need to build the Android app or widgets.
- Recommended tooling:
  - [`just`](https://github.com/casey/just) for the task runner.
  - `python3` + `rsvg-convert` only when regenerating the app icon.

```sh
flutter pub get
just gen        # l10n + generated code
just check      # format, analyse and test
```

## Workflow

1. Branch from `main` with a descriptive name, e.g. `feat/swipe-to-delete` or
   `fix/rtl-agenda-spacing`.
2. Make focused changes; keep unrelated refactors in separate commits.
3. Regenerate code whenever you touch an entity, provider or ARB file
   (`just gen`).
4. Run `just check` and make sure it is green.
5. Open a pull request describing **what** changed and **why**, with
   screenshots/GIFs for UI work. Note the light, dark and RTL checks you ran.

### Commits

Use short, imperative subjects (`add swipe-to-delete on today`). Reference
issues in the body where relevant.

## Architecture rules

The full contract is in [AGENTS.md](AGENTS.md) — read it before touching code.
The essentials:

- **Dependency direction:** `features → domain ← data`, and everything may use
  `anjiz_ui` and `core`. `domain` is pure Dart (no Flutter imports). Features
  never import `data`.
- **All UI primitives live in `packages/anjiz_ui`.** If a feature needs a new
  button, card, row, sheet, chip, loader or empty state, add it to `anjiz_ui`
  first (with a short doc comment and a barrel export). Features only compose.
- **No hard-coded colours, sizes, radii, durations or strings.** Use
  `AnjizSpacing`, `AnjizShapes`, `AnjizMotion`, theme tokens and
  `lib/l10n/*.arb`.
- **Small files.** Target ≤150 lines, hard cap 250. One public widget/class per
  file, `snake_case.dart` with the conventional suffixes (`_screen`,
  `_provider`, `_repository`, `_dao`, `_entity`).
- **Screens are thin.** They compose `anjiz_ui` components with provider state;
  logic belongs in use cases (domain) and notifiers (presentation). Widgets
  never touch Drift or platform services directly.
- **Barrels.** Import a package/feature through its barrel export only.
- **Accessibility.** Minimum 48 dp touch targets, semantic labels on icon
  buttons and the task checkbox, support text scale up to 2.0 and reduced motion.
- **Dynamic colour first.** Light and dark; RTL-safe via `EdgeInsetsDirectional`
  and `AlignmentDirectional`.

## Adding a feature

Mirror the existing structure:

```
lib/features/<feature>/
├── presentation/
│   ├── screens/    # *_screen.dart — thin, composes widgets
│   ├── widgets/    # feature-only compositions of anjiz_ui
│   └── providers/  # Riverpod notifiers
└── <feature>.dart  # barrel
```

Add the route in `lib/app/app_routes.dart` and `lib/app/router.dart`, and cover
new logic with tests under `test/`.

## Code generation

Generated files (`*.g.dart`, `*.freezed.dart`, localisations) are never edited
by hand:

- localisations: `just l10n`
- everything else: `just codegen`
- both: `just gen`

## Tests

```sh
just test       # app suite
just test-ui    # packages/anjiz_ui suite
just test-all   # both
```

- Put tests under `test/` mirroring `lib/`.
- Cover new domain/use-case logic and any new `anjiz_ui` component behaviour.
- Mock with `mocktail`.

## Localisation

English is the only supported language today, but **all** user-visible text must
go through `lib/l10n/app_en.arb`. Native widget labels are the one exception:
they live in `android/app/src/main/res/values/strings.xml`, because the widget
process cannot reach Flutter's localisations. Keep the two in sync when you
change widget copy.

## Widgets and platforms

- Widget data flows one way: `WidgetSyncService` pushes a JSON snapshot; the
  Kotlin renderers stay dumb. Never add a second place that writes widget data.
- Tap actions run through the background isolate in
  `lib/app/widget_background.dart`.
- `WidgetSyncService` must be called after every task mutation.

## Pull request checklist

- [ ] `just check` passes (format, analyse with zero issues, all tests).
- [ ] Generated code is regenerated and committed.
- [ ] No file exceeds the 250-line cap; no UI primitive added outside `anjiz_ui`.
- [ ] No hard-coded colours, sizes, durations or user-visible strings.
- [ ] Light, dark and RTL verified (and tablet widths for layout changes).
- [ ] [CHANGELOG.md](CHANGELOG.md) updated under `## [Unreleased]`.

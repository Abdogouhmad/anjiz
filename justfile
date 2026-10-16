# Anjiz developer tasks. Run `just` to list recipes.
#
# Requires: Flutter (with Dart), plus `python3` and `rsvg-convert` for `just icons`.
set shell := ["bash", "-euo", "pipefail", "-c"]
set dotenv-load := false

ui_dir := "packages/anjiz_ui"

# List available recipes.
default:
    @just --list --unsorted

# Fetch dependencies for the whole Dart workspace.
pub-get:
    flutter pub get

# Regenerate localisations from lib/l10n/*.arb.
l10n:
    flutter gen-l10n

# Regenerate Freezed / Drift / Riverpod / JSON code (deletes stale outputs).
codegen:
    dart run build_runner build --delete-conflicting-outputs

# Regenerate localisations and all generated code.
gen: l10n codegen

# Static analysis (must be clean: zero issues).
analyze:
    flutter analyze

# Run the app test suite.
test:
    flutter test

# Run the anjiz_ui design-system test suite.
test-ui:
    cd {{ui_dir}} && flutter test

# Run every test suite.
test-all: test test-ui

# Format the whole workspace.
format:
    dart format .

# Verify formatting without writing (CI-friendly).
format-check:
    dart format --output none --set-exit-if-changed .

# Rasterise the icon layers, check the safe zone, and regenerate Android resources.
icons:
    tool/render_icons.sh
    tool/check_icon_safe_zone.py assets/icon/ic_foreground.png assets/icon/ic_monochrome.png
    dart run flutter_launcher_icons

# Verify the launcher layers still survive every Android mask (no writes).
icon-check:
    tool/check_icon_safe_zone.py assets/icon/ic_foreground.png assets/icon/ic_monochrome.png

# Build a debug APK.
apk:
    flutter build apk --release --split-per-abi

# Build a release app bundle.
appbundle:
    flutter build appbundle --release

# Print the release tag/version/versionCode derived from pubspec.yaml.
version:
    ./build.sh --detect-version

# Extract this version's CHANGELOG section into dist/notes.md.
release-notes:
    ./build.sh --release-notes

# Build, sign and stage the release APKs (universal + split) under dist/.
release:
    ./build.sh

# Run on the connected device/emulator.
run:
    flutter run

# Run on the Linux desktop target (fast UI iteration; no widgets/reminders).
run-linux:
    flutter run -d linux

# Run on a connected Android device/emulator.
run-android:
    flutter run -d android

# List attached devices.
devices:
    flutter devices

# List and launch available Android emulators.
emulators:
    flutter emulators
    @echo "Launch one with: flutter emulators --launch <id>"

# Full pre-PR check: formatting, codegen freshness, analysis and tests.
check: format analyze test-all

# Remove build artefacts.
clean:
    flutter clean

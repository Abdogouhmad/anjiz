#!/usr/bin/env bash
#
# Rasterise the Anjiz launcher icon from the vector drawables in `assets/icons/`
# into the PNG layers consumed by `flutter_launcher_icons` (see AGENTS.md §7).
#
#   assets/icons/*.xml  ->  SVG  ->  assets/icon/*.png
#
# Requires: python3, rsvg-convert (librsvg). Run from the repository root:
#
#   tool/render_icons.sh
#
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src="$root/assets/icons"
out="$root/assets/icon"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

convert() { python3 "$root/tool/rasterize_icons.py" "$@"; }

# 432x432 adaptive layers (108dp canvas, 4x density).
convert "$src/ic_launcher_background.xml" "$work/background.svg"
convert "$src/ic_launcher_foreground.xml" "$work/foreground.svg" "18 18 72 72"
convert "$src/ic_launcher_monochrome.xml" "$work/monochrome.svg" "18 18 72 72"

rsvg-convert -w 432 -h 432 "$work/background.svg" -o "$out/ic_background.png"
rsvg-convert -w 432 -h 432 "$work/foreground.svg" -o "$out/ic_foreground.png"
rsvg-convert -w 432 -h 432 "$work/monochrome.svg" -o "$out/ic_monochrome.png"

# Google Play listing icon: shipped as a 512x512 PNG design asset.
cp "$src/play_store_512.png" "$out/ic_playstore_512.png"

echo "Rendered launcher layers into assets/icon/"

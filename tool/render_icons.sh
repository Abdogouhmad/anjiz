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
#
# Render the *whole* 108dp canvas for every layer: the launcher scales the
# foreground and monochrome layers so their full extent covers 108dp, then masks
# them to the middle 72dp. Cropping the artwork here (e.g. to `18 18 72 72`)
# would zoom it 1.5x and push the glyph outside the 66dp safe-zone circle, where
# every launcher mask clips it. The glyphs stay inside the safe zone on their
# own (see `tool/check_icon_safe_zone.py`).
convert "$src/ic_launcher_background.xml" "$work/background.svg"
convert "$src/ic_launcher_foreground.xml" "$work/foreground.svg"
convert "$src/ic_launcher_monochrome.xml" "$work/monochrome.svg"

rsvg-convert -w 432 -h 432 "$work/background.svg" -o "$out/ic_background.png"
rsvg-convert -w 432 -h 432 "$work/foreground.svg" -o "$out/ic_foreground.png"
rsvg-convert -w 432 -h 432 "$work/monochrome.svg" -o "$out/ic_monochrome.png"

# Google Play listing icon: shipped as a 512x512 PNG design asset.
cp "$src/play_store_512.png" "$out/ic_playstore_512.png"

echo "Rendered launcher layers into assets/icon/"

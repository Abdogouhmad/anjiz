#!/usr/bin/env python3
"""Check that the adaptive-icon layers survive every Android launcher mask.

Android lays a 108dp canvas under a mask that only guarantees a 72dp visible
area, and its design guidance reserves a 66dp *safe-zone* circle inside that. A
glyph that reaches past 33dp from the centre gets clipped on some phones (a
Pixel's squircle cuts more than a circle does), and one past 36dp is clipped by
every mask.

This script measures the opaque pixels of each layer and reports the farthest
one from the centre in dp, so `tool/render_icons.sh` output can be verified
before shipping. It needs ImageMagick (`magick`) to decode the PNGs:

    tool/check_icon_safe_zone.py assets/icon/ic_foreground.png
"""

from __future__ import annotations

import re
import subprocess
import sys

#: The adaptive-icon canvas, in dp. Every layer PNG is that wide at 1x.
CANVAS_DP = 108

#: Guaranteed-unclipped radius from Android's icon design guidance.
SAFE_RADIUS_DP = 33.0

#: Radius of the 72dp visible area the masks are inscribed in.
VISIBLE_RADIUS_DP = 36.0


def alpha_values(path: str) -> tuple[int, int, list[int], int]:
    """Decode [path]'s alpha channel as (width, height, values, max_value)."""
    dump = subprocess.run(
        [
            "magick",
            path,
            "-alpha",
            "extract",
            "-depth",
            "8",
            "-compress",
            "none",
            "pgm:-",
        ],
        check=True,
        capture_output=True,
    ).stdout.decode("ascii", "replace")
    tokens = [t for t in re.split(r"\s+", dump) if t and not t.startswith("#")]
    if not tokens or tokens[0] != "P2":
        raise ValueError(f"{path}: expected an ASCII PGM dump, got {tokens[:1]}")
    width, height, max_value = (int(tokens[i]) for i in (1, 2, 3))
    values = [int(v) for v in tokens[4:]]
    if len(values) != width * height:
        raise ValueError(f"{path}: {len(values)} samples for {width}x{height}")
    return width, height, values, max_value


def check(path: str) -> bool:
    """Report on one layer, returning False when it would be clipped."""
    width, height, values, max_value = alpha_values(path)
    px_per_dp = width / CANVAS_DP
    centre_x, centre_y = (width - 1) / 2, (height - 1) / 2
    opaque = 0
    farthest_px = 0.0
    for index, value in enumerate(values):
        if value * 2 <= max_value:
            continue
        opaque += 1
        x, y = index % width, index // width
        farthest_px = max(farthest_px, ((x - centre_x) ** 2 + (y - centre_y) ** 2) ** 0.5)

    name = path.rsplit("/", 1)[-1]
    if opaque == width * height:
        # A background layer is meant to bleed to the edges of the canvas and is
        # never masked away by launchers.
        print(f"{name}: full-bleed background, 108dp canvas — OK")
        return True

    farthest_dp = farthest_px / px_per_dp
    if farthest_dp <= SAFE_RADIUS_DP:
        verdict = f"OK — inside the {SAFE_RADIUS_DP:.0f}dp safe zone"
        ok = True
    elif farthest_dp <= VISIBLE_RADIUS_DP:
        verdict = "AT RISK — outside the safe zone, some masks clip it"
        ok = False
    else:
        verdict = "CLIPPED — outside the visible area, every mask clips it"
        ok = False
    print(
        f"{name}: glyph reaches {farthest_dp:.2f}dp from the centre "
        f"(safe {SAFE_RADIUS_DP:.0f}dp, visible {VISIBLE_RADIUS_DP:.0f}dp) — {verdict}"
    )
    return ok


def main(argv: list[str]) -> int:
    paths = argv[1:]
    if not paths:
        print(__doc__.strip().splitlines()[-1], file=sys.stderr)
        return 2
    return 0 if all(check(path) for path in paths) else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))

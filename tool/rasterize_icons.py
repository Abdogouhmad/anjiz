#!/usr/bin/env python3
"""Convert Android vector-drawable XML icon layers into SVG.

Only the subset used by the Anjiz icon is supported: a flat list of <path>
elements plus an optional linear <gradient> fill.
"""
import re
import sys
import xml.etree.ElementTree as ET

ANDROID = "{http://schemas.android.com/apk/res/android}"
AAPT = "{http://schemas.android.com/aapt}"


def local(tag):
    return tag.rsplit("}", 1)[-1]


def color_to_svg(value):
    """#AARRGGBB or #RRGGBB -> #RRGGBBAA for SVG."""
    value = value.strip()
    if not value.startswith("#"):
        return value
    hexits = value[1:]
    if len(hexits) == 8:
        aa, rr, gg, bb = hexits[0:2], hexits[2:4], hexits[4:6], hexits[6:8]
        return f"#{rr}{gg}{bb}{aa}"
    return "#" + hexits


def gradient_fill(element, defs, uid):
    for child in element:
        if local(child.tag) != "attr":
            continue
        if child.get("name") != "android:fillColor":
            continue
        gradient = next((g for g in child if local(g.tag) == "gradient"), None)
        if gradient is None:
            continue
        stops = []
        for item in gradient:
            if local(item.tag) != "item":
                continue
            offset = item.get(ANDROID + "offset", "0")
            color = color_to_svg(item.get(ANDROID + "color", "#00000000"))
            stops.append(
                f'<stop offset="{offset}" stop-color="{color[:7]}"'
                f' stop-opacity="{int(color[7:9], 16) / 255:.3f}"/>'
            )
        x1 = gradient.get(ANDROID + "startX", "0")
        y1 = gradient.get(ANDROID + "startY", "0")
        x2 = gradient.get(ANDROID + "endX", "0")
        y2 = gradient.get(ANDROID + "endY", "0")
        defs.append(
            f'<linearGradient id="{uid}" gradientUnits="userSpaceOnUse"'
            f' x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}">'
            + "".join(stops)
            + "</linearGradient>"
        )
        return f"url(#{uid})"
    return None


def convert(source, target, viewbox=None):
    tree = ET.parse(source)
    vector = tree.getroot()
    width = vector.get(ANDROID + "viewportWidth", "108")
    height = vector.get(ANDROID + "viewportHeight", "108")
    if viewbox is None:
        viewbox = f"0 0 {width} {height}"

    defs = []
    body = []
    for index, element in enumerate(vector):
        kind = local(element.tag)
        path_data = element.get(ANDROID + "pathData")
        if kind != "path" or not path_data:
            continue
        attrs = [f'd="{path_data}"']
        fill = gradient_fill(element, defs, f"grad{index}")
        fill_attr = element.get(ANDROID + "fillColor")
        stroke_attr = element.get(ANDROID + "strokeColor")
        if fill is None and fill_attr is not None:
            fill = color_to_svg(fill_attr)
        if fill is None and stroke_attr is None:
            fill = "#FF000000"
        if fill is None:
            attrs.append('fill="none"')
        else:
            rule = element.get(ANDROID + "fillType", "nonZero")
            if rule == "evenOdd":
                attrs.append('fill-rule="evenodd"')
            if fill.startswith("#") and len(fill) == 9:
                attrs.append(f'fill-opacity="{int(fill[7:9], 16) / 255:.3f}"')
                fill = fill[:7]
            attrs.append(f'fill="{fill}"')
        if stroke_attr is not None:
            stroke = color_to_svg(stroke_attr)
            if len(stroke) == 9:
                attrs.append(f'stroke-opacity="{int(stroke[7:9], 16) / 255:.3f}"')
                stroke = stroke[:7]
            attrs.append(f'stroke="{stroke}"')
            attrs.append(
                f'stroke-width="{element.get(ANDROID + "strokeWidth", "1")}"'
            )
            for attribute, css in (
                ("strokeLineCap", "stroke-linecap"),
                ("strokeLineJoin", "stroke-linejoin"),
            ):
                value = element.get(ANDROID + attribute, "").lower()
                if value:
                    attrs.append(f'{css}="{value}"')
        body.append("<path " + " ".join(attrs) + "/>")

    svg = (
        f'<svg xmlns="http://www.w3.org/2000/svg" width="{width}"'
        f' height="{height}" viewBox="{viewbox}">'
        + (f"<defs>{''.join(defs)}</defs>" if defs else "")
        + "".join(body)
        + "</svg>"
    )
    with open(target, "w", encoding="utf-8") as handle:
        handle.write(svg)


if __name__ == "__main__":
    convert(sys.argv[1], sys.argv[2], sys.argv[3] if len(sys.argv) > 3 else None)

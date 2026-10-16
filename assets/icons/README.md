# Anjiz icon sources

Vector-drawable source layers for the adaptive launcher icon. AGENTS.md §7.

| File | Purpose |
| --- | --- |
| `ic_launcher.xml` | Full icon, as drawn in the Stitch preview (design reference). |
| `ic_launcher_background.xml` | Adaptive background layer (108dp canvas). |
| `ic_launcher_foreground.xml` | Adaptive foreground layer. |
| `ic_launcher_monochrome.xml` | Android 13+ themed-icon layer. |
| `play_store_512.png` | Google Play listing icon (512x512). |
| `preview_masks.png` | Design reference showing the icon under launcher masks. |

## Rendering

`flutter_launcher_icons` consumes PNG layers, but these sources are vectors, so
run the render script to (re)generate them:

```sh
tool/render_icons.sh          # needs python3 + rsvg-convert
```

It converts the XML layers to SVG (`tool/rasterize_icons.py`) and rasterises
them into `assets/icon/`:

- `ic_background.png`, `ic_foreground.png`, `ic_monochrome.png` — 432x432.
  Foreground and monochrome are rendered with a `18 18 72 72` viewBox so the
  glyph fills ~84% of the canvas; the remaining margin is the adaptive safe zone
  (`adaptive_icon_foreground_inset: 0`).
- `ic_playstore_512.png` — copied from `play_store_512.png`.

Then generate the Android resources:

```sh
dart run flutter_launcher_icons
```

which writes the `mipmap-*`/`drawable-*` PNGs and
`mipmap-anydpi-v26/ic_launcher.xml` (must contain a `<monochrome>` layer).

## Coverage

- Android 13+ / Pixel themed icons: `<monochrome>` layer (the check is a real
  cut-out, so it tints with the wallpaper colours).
- Android 8–12: adaptive icon (any launcher mask: circle, squircle, rounded
  square, teardrop).
- Android 7.1 and below: legacy PNG mipmaps (mdpi–xxxhdpi).
- Google Play: `play_store_512.png` (upload as-is; Play applies its own mask).

Android 12+ splash screens reuse the adaptive icon automatically. To customise,
point `android:windowSplashScreenAnimatedIcon` at `@drawable/ic_launcher_foreground`.

---
name: Injaz Productivity System
colors:
  surface: '#f2fcf5'
  surface-dim: '#d2dcd6'
  surface-bright: '#f2fcf5'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#ecf6f0'
  surface-container: '#e6f0ea'
  surface-container-high: '#e0ebe4'
  surface-container-highest: '#dbe5df'
  on-surface: '#141d1a'
  on-surface-variant: '#3e4945'
  inverse-surface: '#29322e'
  inverse-on-surface: '#e9f3ed'
  outline: '#6e7a75'
  outline-variant: '#bec9c4'
  surface-tint: '#006b58'
  primary: '#00604f'
  on-primary: '#ffffff'
  primary-container: '#1b7a66'
  on-primary-container: '#afffe7'
  inverse-primary: '#81d6bf'
  secondary: '#4c635b'
  on-secondary: '#ffffff'
  secondary-container: '#cce5db'
  on-secondary-container: '#50675f'
  tertiary: '#704e00'
  on-tertiary: '#ffffff'
  tertiary-container: '#8b661b'
  on-tertiary-container: '#ffedd3'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#9df3da'
  primary-fixed-dim: '#81d6bf'
  on-primary-fixed: '#002019'
  on-primary-fixed-variant: '#005142'
  secondary-fixed: '#cfe8de'
  secondary-fixed-dim: '#b3ccc2'
  on-secondary-fixed: '#091f19'
  on-secondary-fixed-variant: '#354b44'
  tertiary-fixed: '#ffdea9'
  tertiary-fixed-dim: '#eebf6c'
  on-tertiary-fixed: '#271900'
  on-tertiary-fixed-variant: '#5e4100'
  background: '#f2fcf5'
  on-background: '#141d1a'
  surface-variant: '#dbe5df'
typography:
  display-lg:
    fontFamily: Roboto Flex
    fontSize: 44px
    fontWeight: '700'
    lineHeight: 52px
    letterSpacing: -0.5px
  display-lg-mobile:
    fontFamily: Roboto Flex
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.25px
  headline-lg:
    fontFamily: Roboto Flex
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
  headline-md:
    fontFamily: Roboto Flex
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 36px
  title-lg:
    fontFamily: Roboto Flex
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
  title-md:
    fontFamily: Roboto Flex
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: 0.15px
  title-sm:
    fontFamily: Roboto Flex
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.1px
  body-lg:
    fontFamily: Roboto Flex
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: 0.5px
  body-md:
    fontFamily: Roboto Flex
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: 0.25px
  label-lg:
    fontFamily: Roboto Flex
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.1px
  label-md:
    fontFamily: Roboto Flex
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.5px
  label-sm:
    fontFamily: Roboto Flex
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.5px
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  gutter: 16px
  gutter-tablet: 24px
  gutter-desktop: 24px
  margin: 16px
  margin-tablet: 24px
  margin-desktop: 48px
  space-xs: 4px
  space-sm: 8px
  space-md: 16px
  space-lg: 24px
  space-xl: 32px
---

## Brand & Style

This design system expresses disciplined intentionality, kinetic clarity, and serene productivity. Tailored specifically as a native Android experience rooted in Material 3 Expressive, it balances human warmth with structural rigor. It caters to proactive professionals, students, and bilingual makers who view daily task management not as an endless chore, but as sustained momentum ("إنجاز" — achievement).

The visual aesthetic synthesizes **Material 3 Expressive** with tactile biometric feedback:
- **Tonal Depth Over Flatness:** Dynamic surface container steps replace artificial shadows, creating distinct physical layers that mimic stacked paper cards and tangible organizing tabs.
- **Organic Expressive Geometries:** Moving beyond standard rounded rectangles into variable pill silhouettes, expanding floating actions, and celebratory scalloped/cookie burst containers for milestone completions.
- **Bi-Directional Native Balance:** Designed from the ground up for optical parity across both Latin and Arabic scripts, ensuring typographic weights and kinetic iconography feel equally grounded in LTR and RTL reading postures.

## Colors

The palette establishes an organic, focused visual field anchored by an emerald core, soft sage utility, and warm honey alerts.

### Roles & Tonal Tokens (Light Mode)
- **Primary (`#1B7A66`):** Key interactive surfaces, filled state buttons, and selected navigation destinations.
  - `on-primary`: `#FFFFFF`
  - `primary-container`: `#A3F2DC`
  - `on-primary-container`: `#002019`
- **Secondary (`#4C635B`):** Supporting contextual metadata, passive categorization tags, and inactive filter states.
  - `on-secondary`: `#FFFFFF`
  - `secondary-container`: `#CEE8DE`
  - `on-secondary-container`: `#082019`
- **Tertiary (`#7B580C`):** Time-sensitive cues, overdue alerts, high-priority star states, and progress milestone bursts.
  - `on-tertiary`: `#FFFFFF`
  - `tertiary-container`: `#FFDEA3`
  - `on-tertiary-container`: `#271900`
- **Surfaces & Tonal Stack:**
  - `surface`: `#F5FAF7`
  - `surface-dim`: `#D6DBD8`
  - `surface-bright`: `#F5FAF7`
  - `surface-container-lowest`: `#FFFFFF` (Primary task card ground)
  - `surface-container-low`: `#EFF5F1`
  - `surface-container`: `#E9EFEB` (Canvas backing)
  - `surface-container-high`: `#E3EAE5`
  - `surface-container-highest`: `#DDE4DF` (Bottom sheets and docked bars)
- **Borders & Separation:**
  - `outline`: `#6F7974`
  - `outline-variant`: `#BFC9C3`

### Dark Mode Mapping
- `primary`: `#87D6C1`
- `primary-container`: `#005142`
- `on-primary-container`: `#A3F2DC`
- `surface`: `#0F1513`
- `surface-container`: `#1B211F`
- `surface-container-high`: `#212B28`
- `tertiary`: `#EEC06E`
- `tertiary-container`: `#5B4100`

## Typography

The type system relies on `Roboto Flex` to exploit variable weight, optical sizing, and width axes across bilingual views.

- **Expressive Scale Dynamics:** The top-level header (`display-lg` at 44px weight 700) anchors contextual views ("Today", "This Week") and smoothly collapses into a pinned `title-lg` upon scroll via Android’s Collapsing Top App Bar behavior.
- **Bilingual & Script Support:** Arabic typography requires an optical baseline shift. When rendering Arabic strings (e.g., "اليوم", "قيد الإنجاز"), line-height expands by 1.15x relative to Latin defaults to avoid vowel clipping on glyph ascenders and descenders.
- **Structural Legibility:** All task body copy leverages `body-lg` (16px) with relaxed tracking (0.5px) to maintain readability during rapid scanning and one-handed operation.

## Layout & Spacing

The layout is built around an 8dp baseline grid with a 4dp micro-step for compact icon and inline tag alignment.

### Grid Models & Adaptive Behavior
- **Mobile (Compact, &lt;600dp):** Fluid 4-column system. Outer canvas margins are fixed at `16px`, with `16px` gutters. Elements default to full-width block cards or edge-to-edge list groupings.
- **Foldables & Tablets (Medium, 600–839dp):** 8-column layout with `24px` margins and gutters. Supports dual-pane list-detail architecture (e.g., Task List pane left 38%, Task Detail/Subtasks pane right 62%).
- **Expanded Screens (&ge;840dp):** 12-column layout with `48px` outer margins. Content max-width is constrained to `1200px` centered, allowing persistent vertical navigation rails on the start edge.

### RTL Spacing Discipline
All horizontal padding, margins, and directional constraints must use structural start/end mapping (`paddingStart`, `paddingEnd`). Inline metadata items adhere strictly to `space-sm` (8px) gaps between dynamic badges, leading icons, and timestamp labels.

## Elevation & Depth

Material 3 Expressive eliminates heavy drop shadows, relying instead on tonal mapping and ambient color tinting:

- **Tonal Step System:**
  - Base viewport Canvas sits on `surface-container`.
  - Inactive or completed tasks rest directly on `surface-container-low`.
  - Active interactive task cards elevate to `surface-container-lowest` (#FFFFFF in light mode), creating innate visual lift through contrast rather than physical projection.
  - Floating sheets and dialogue viewports utilize `surface-container-highest`.
- **Soft Ambient Bloom:**
  When a card is dragged or active in re-order mode, apply a subtle ambient shadow: `offset: (0, 8px)`, `blur: 24px`, tinted with `rgba(27, 122, 102, 0.12)`.
- **Expressive Floating Toolbar Elevation:**
  Floating toolbars and expandable FABs use an elevation tint combining `primary-container` backing with a dual-layer soft ambient border (`outline-variant` at 50% opacity) and low-radius shadow (`offset: (0, 4px)`, `blur: 16px`, `rgba(0, 32, 25, 0.08)`).

## Shapes

The shape system adopts M3 Expressive’s bold, hyper-rounded geometry, emphasizing organic curvature and kinetic state transitions:

- **Pill Silhouettes (Fully Rounded, 9999px):** Standard buttons, filter chips, category pills, input search fields, active navigation indicators, and the resting state of the Floating Action Button.
- **Large Container Geometry (28px Corner Radius):** Task cards, bottom sheets, full-bleed modals, and docked status cards.
- **Micro Radii (12px Corner Radius):** Context menus, nested subtask items, and notification banners.
- **Scalloped / Burst Shapes (Expressive Assets):**
  - Task completion checkboxes utilize an 8-lobed organic smooth burst mask when toggled "Done", transitioning fluidly from a circular outline to a morphing scalloped petal.
  - Streak and milestone badges implement a 12-lobed geometry rendered in `tertiary-container`.

## Components

### Buttons & Connected Groups
- **Filled Button:** Height 48dp, 9999px pill corner radius. Background `primary`, text `on-primary` (Typography `label-lg`). Internal horizontal padding 24dp.
- **Tonal Button:** Background `secondary-container`, text `on-secondary-container`.
- **Connected Button Groups (Segmented Button):** Single unified container with 9999px external radius. Internal segment dividers using `outline-variant`. Active segment adopts `primary-container` with `on-primary-container` text; unselected segments adopt transparent backgrounds.

### Floating Action Button (FAB) & Floating Toolbars
- **Resting FAB:** 56dp pill or rounded square (20dp corner radius) filled with `primary-container`, containing a 24dp icon tinted `on-primary-container`.
- **Expanding Menu FAB:** On scroll or press, smoothly scales horizontally to reveal an expressive label alongside secondary micro-action pills (e.g., "Add Voice Note", "Quick Task").
- **Floating Toolbar:** Detached bottom control strip with 28dp pill radius, elevated via `surface-container-highest`, holding action icons separated by 12dp.

### Chips & Filters
- **Filter Chip:** 36dp height, 9999px radius. Border 1dp `outline-variant` when unselected. Selected state fills with `secondary-container`, suppressing border, with an animated checkmark icon at the leading edge.

### Checkboxes & Radios
- **Task Checkbox:** Resting state is an unselected 22dp geometric ring with 2dp border width in `outline`. On selection, animates through an expressive 8-lobe scalloped burst fill in `primary`, housing a bold white checkmark (`on-primary`).

### Input Fields
- **Search & Task Input Bar:** 56dp height, 9999px full pill contour, filled with `surface-container-high` and no external outline. Leading icon in `neutral`, trailing action pill (e.g., "Submit" or "Filter") nested with 4dp internal margin.

### Cards & Task Rows
- **Task Card:** 28dp corner radius. Background `surface-container-lowest`. Padding 16dp. Left-accented (or right-accented in RTL) priority indicators use a 4dp wide vertical pill filled with `tertiary`. Strikethrough animations on completion dim text to `neutral` and trigger a micro-scale bounce.

### Wavy Progress Indicators
- Linear and circular progress indicators leverage continuous sine-wave modulation along the track in `primary`, resting on an inactive track of `surface-container-highest`.

### Bottom Sheets
- Rounded top corners at 28dp radius, flat bottom. Drag handle centered: 32dp width, 4dp height, 9999px radius, filled with `outline-variant`.

### RTL Behavioral Rules
All iconography reflecting progress, directional movement (arrows, swipes), or asymmetric layout components mirror automatically under RTL layouts, while status icons (battery, time, scalar metrics) remain structurally stable.
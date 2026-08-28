# GTA6 for Omarchy

A restrained Grand Theft Auto VI fan theme collection for Omarchy. Vice Sunset is the default; fifteen additional editions derive their surfaces and focus colors from one paired wallpaper each.

## Install

```bash
omarchy theme install https://github.com/debpalash/omarchy-gta6-theme.git
```

Omarchy installs the repository as `gta6` and rebuilds protected application configs from `colors.toml`.

## Included

- Twenty-seven original-resolution SFW backgrounds, including every supplied Wallhaven link
- Sixteen complete Omarchy Quattro palettes: Vice Sunset plus fifteen wallpaper-specific editions
- Yaru Magenta icons
- Shell palettes tuned for long sessions, not a full-screen neon effect

## Wallpaper editions

The normal install uses **Vice Sunset** and contains the full wallpaper collection. Additional editions live in [`variants/`](variants/) and export as independent Omarchy themes with only their paired wallpaper.

Create and switch to an edition with:

```bash
~/.config/omarchy/themes/gta6/scripts/create-variant.sh leonida-blue
```

See [the edition guide](variants/README.md) for all names and wallpaper cues. The helper only runs when called directly, refuses to overwrite an existing theme, and keeps `omarchy theme update` pulling the original `gta6` repository cleanly.

## Design decisions

- Color: each edition starts with dominant tones extracted from its wallpaper, then deepens or lightens them for readable surfaces.
- Accent: a real focal color from the paired artwork marks focus and primary state.
- Support colors: status colors bend toward the image without losing their terminal meaning.
- Typography: Omarchy keeps the user's configured font so a visual theme never changes reading behavior.
- Spacing and layout: the theme leaves Omarchy's layout untouched because the makeover should feel native.
- Artwork: broad scenic compositions keep windows readable and reserve logos for one optional background.

## Artwork and trademark notice

Background images retain their original ownership and are not covered by the MIT license. Source pages, uploaders, resolutions, and upstream source metadata are listed in [ASSETS.md](ASSETS.md). Grand Theft Auto, GTA, Rockstar Games, and related marks belong to their respective owners. This is an unofficial, non-commercial fan theme and is not endorsed by Rockstar Games or Take-Two Interactive.

The configuration and documentation in this repository are licensed under MIT.

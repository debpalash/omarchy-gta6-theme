# GTA6 for Omarchy

A restrained Grand Theft Auto VI fan theme collection for Omarchy. The default Vice Sunset palette keeps the desktop dark and readable, then lets flamingo pink, pool-water cyan, warm sand, and the supplied artwork carry the atmosphere.

## Install

```bash
omarchy theme install https://github.com/debpalash/omarchy-gta6-theme.git
```

Omarchy installs the repository as `gta6` and rebuilds protected application configs from `colors.toml`.

## Included

- Twelve original-resolution SFW backgrounds selected from the requested [Wallhaven GTA VI search](https://wallhaven.cc/search?q=Grand+Theft+Auto+VI&categories=110&purity=100&sorting=relevance&order=desc)
- Four complete Omarchy Quattro palettes: Vice Sunset, Ocean Drive, Leonida Night, and Biscayne Day
- Yaru Magenta icons
- Shell palettes tuned for long sessions, not a full-screen neon effect

## Palette variants

The normal install uses **Vice Sunset**. The other palettes live in [`variants/`](variants/) and can be exported as independent Omarchy themes without changing the git-managed `gta6` checkout:

- **Ocean Drive** — deep blue-black surfaces with pool-water cyan focus
- **Leonida Night** — midnight plum with warm streetlight gold focus
- **Biscayne Day** — a low-glare sand-and-sea light theme

Create and switch to one with:

```bash
~/.config/omarchy/themes/gta6/scripts/create-variant.sh ocean-drive
```

See [the variant guide](variants/README.md) for all names and behavior. The helper only runs when called directly, refuses to overwrite an existing theme, and keeps `omarchy theme update` pulling the original `gta6` repository cleanly.

## Design decisions

- Color: charcoal-plum surfaces echo the night scenes without tinting every panel pink.
- Accent: each palette gets one clear focus color rather than tinting every surface.
- Support colors: pool-water cyan and sunset gold keep status colors legible while staying inside the source art.
- Typography: Omarchy keeps the user's configured font so a visual theme never changes reading behavior.
- Spacing and layout: the theme leaves Omarchy's layout untouched because the makeover should feel native.
- Artwork: broad scenic compositions keep windows readable and reserve logos for one optional background.

## Artwork and trademark notice

Background images retain their original ownership and are not covered by the MIT license. Source pages, uploaders, resolutions, and upstream source metadata are listed in [ASSETS.md](ASSETS.md). Grand Theft Auto, GTA, Rockstar Games, and related marks belong to their respective owners. This is an unofficial, non-commercial fan theme and is not endorsed by Rockstar Games or Take-Two Interactive.

The configuration and documentation in this repository are licensed under MIT.

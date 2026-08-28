#!/usr/bin/env bash

set -euo pipefail

theme_dir="${1:-.}"

python3 - "$theme_dir" <<'PY'
import pathlib
import sys
import json
import tomllib

root = pathlib.Path(sys.argv[1])

required = {
    "mode", "accent", "selection", "muted", "background", "dark_background",
    "darker_background", "lighter_background", "foreground", "dark_foreground",
    "light_foreground", "bright_foreground", "red", "yellow", "orange", "green",
    "cyan", "blue", "magenta", "brown", "bright_red", "bright_yellow",
    "bright_green", "bright_cyan", "bright_blue", "bright_magenta",
}

with (root / "variants" / "catalog.json").open() as handle:
    catalog = json.load(handle)

editions = catalog.get("editions", [])
if len(editions) != 16:
    raise SystemExit("default palette and fifteen wallpaper editions are required")

slugs = [edition["slug"] for edition in editions]
if len(slugs) != len(set(slugs)):
    raise SystemExit("edition slugs must be unique")
if catalog.get("default") != "vice-sunset" or editions[0]["slug"] != "vice-sunset":
    raise SystemExit("vice-sunset must remain the default edition")

palette_paths = [root / edition["palette"] for edition in editions]
wallpaper_paths = [root / edition["wallpaper"] for edition in editions]
for path in [*palette_paths, *wallpaper_paths]:
    if not path.is_file():
        raise SystemExit(f"edition file is missing: {path}")

def luminance(value):
    channels = [int(value[index:index + 2], 16) / 255 for index in (1, 3, 5)]
    channels = [channel / 12.92 if channel <= 0.04045 else ((channel + 0.055) / 1.055) ** 2.4 for channel in channels]
    return 0.2126 * channels[0] + 0.7152 * channels[1] + 0.0722 * channels[2]

for palette_path in palette_paths:
    with palette_path.open("rb") as handle:
        colors = tomllib.load(handle)

    missing = sorted(required - colors.keys())
    if missing:
        raise SystemExit(f"{palette_path}: missing colors: {', '.join(missing)}")

    if colors["mode"] not in {"dark", "light"}:
        raise SystemExit(f"{palette_path}: mode must be dark or light")

    for key in required - {"mode"}:
        value = colors[key]
        if not isinstance(value, str) or len(value) != 7 or not value.startswith("#"):
            raise SystemExit(f"{palette_path}: {key} is not a #RRGGBB color")
        int(value[1:], 16)

    background_luminance = luminance(colors["background"])
    for key in ("accent", "foreground"):
        color_luminance = luminance(colors[key])
        ratio = (max(background_luminance, color_luminance) + 0.05) / (min(background_luminance, color_luminance) + 0.05)
        if ratio < 4.5:
            raise SystemExit(f"{palette_path}: {key} contrast is only {ratio:.2f}:1")

backgrounds = sorted((root / "backgrounds").glob("*"))
if len(backgrounds) != 27:
    raise SystemExit("exactly 27 backgrounds are required")

with (root / "assets.json").open() as handle:
    assets = json.load(handle)["assets"]
asset_files = [asset["file"] for asset in assets]
background_files = [str(path.relative_to(root)) for path in backgrounds]
if len(asset_files) != len(set(asset_files)) or sorted(asset_files) != background_files:
    raise SystemExit("assets.json must record every background exactly once")

print(f"validated {len(palette_paths)} palettes and {len(backgrounds)} backgrounds")
PY

while IFS= read -r -d '' background; do
  case "$(file --mime-type -b "$background")" in
    image/png | image/jpeg) ;;
    *)
      echo "background directory contains a non-image file: $background" >&2
      exit 1
      ;;
  esac
done < <(find "$theme_dir/backgrounds" -maxdepth 1 -type f -print0)

echo "theme validation passed"

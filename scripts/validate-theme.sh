#!/usr/bin/env bash

set -euo pipefail

theme_dir="${1:-.}"

python3 - "$theme_dir" <<'PY'
import pathlib
import sys
import tomllib

root = pathlib.Path(sys.argv[1])

required = {
    "mode", "accent", "selection", "muted", "background", "dark_background",
    "darker_background", "lighter_background", "foreground", "dark_foreground",
    "light_foreground", "bright_foreground", "red", "yellow", "orange", "green",
    "cyan", "blue", "magenta", "brown", "bright_red", "bright_yellow",
    "bright_green", "bright_cyan", "bright_blue", "bright_magenta",
}

palette_paths = [root / "colors.toml", *sorted((root / "variants").glob("*.toml"))]
if len(palette_paths) < 4:
    raise SystemExit("default palette and three variants are required")

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
if len(backgrounds) < 2:
    raise SystemExit("at least two backgrounds are required")

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

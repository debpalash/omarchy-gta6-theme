#!/usr/bin/env bash

set -euo pipefail

theme_dir="${1:-.}"

python3 - "$theme_dir" <<'PY'
import pathlib
import sys
import tomllib

root = pathlib.Path(sys.argv[1])
with (root / "colors.toml").open("rb") as handle:
    colors = tomllib.load(handle)

required = {
    "mode", "accent", "selection", "muted", "background", "dark_background",
    "darker_background", "lighter_background", "foreground", "dark_foreground",
    "light_foreground", "bright_foreground", "red", "yellow", "orange", "green",
    "cyan", "blue", "magenta", "brown", "bright_red", "bright_yellow",
    "bright_green", "bright_cyan", "bright_blue", "bright_magenta",
}

missing = sorted(required - colors.keys())
if missing:
    raise SystemExit(f"missing colors: {', '.join(missing)}")

if colors["mode"] not in {"dark", "light"}:
    raise SystemExit("mode must be dark or light")

for key in required - {"mode"}:
    value = colors[key]
    if not isinstance(value, str) or len(value) != 7 or not value.startswith("#"):
        raise SystemExit(f"{key} is not a #RRGGBB color")
    int(value[1:], 16)

backgrounds = sorted((root / "backgrounds").glob("*"))
if len(backgrounds) < 2:
    raise SystemExit("at least two backgrounds are required")

print(f"validated {len(required)} theme keys and {len(backgrounds)} backgrounds")
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

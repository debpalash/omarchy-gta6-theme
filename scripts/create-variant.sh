#!/usr/bin/env bash

set -euo pipefail

source_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
catalog="$source_dir/variants/catalog.json"
variant="${1:-}"

edition=$(jq -cer --arg slug "$variant" '.default as $default | .editions[] | select(.slug == $slug and .slug != $default)' "$catalog" 2>/dev/null || true)
if [[ -z "$edition" ]]; then
  echo "Usage: ${0##*/} <edition>" >&2
  echo "Editions:" >&2
  jq -r '.default as $default | .editions[] | select(.slug != $default) | "  " + .slug' "$catalog" >&2
  exit 2
fi

palette=$(jq -r '.palette' <<<"$edition")
wallpaper=$(jq -r '.wallpaper' <<<"$edition")
target_root="${XDG_CONFIG_HOME:-$HOME/.config}/omarchy/themes"
target_dir="$target_root/gta6-$variant"

if [[ ! -d "$source_dir/.git" ]]; then
  echo "Run this helper from the git-managed gta6 theme installation." >&2
  exit 1
fi

if [[ -e "$target_dir" ]]; then
  echo "Refusing to overwrite existing theme: $target_dir" >&2
  exit 1
fi

scratch=$(mktemp -d)
trap 'rm -rf -- "$scratch"' EXIT

git -C "$source_dir" archive HEAD -- README.md LICENSE ASSETS.md assets.json icons.theme "$wallpaper" | tar -x -C "$scratch"
cp "$source_dir/$palette" "$scratch/colors.toml"
mkdir -p "$target_root"
mv "$scratch" "$target_dir"
trap - EXIT

omarchy theme set "gta6-$variant"

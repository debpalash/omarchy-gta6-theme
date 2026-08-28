#!/usr/bin/env bash

set -euo pipefail

variant="${1:-}"
case "$variant" in
  ocean-drive | leonida-night | biscayne-day) ;;
  *)
    echo "Usage: ${0##*/} {ocean-drive|leonida-night|biscayne-day}" >&2
    exit 2
    ;;
esac

source_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
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

git -C "$source_dir" archive HEAD | tar -x -C "$scratch"
cp "$scratch/variants/$variant.toml" "$scratch/colors.toml"
mkdir -p "$target_root"
mv "$scratch" "$target_dir"
trap - EXIT

omarchy theme set "gta6-$variant"

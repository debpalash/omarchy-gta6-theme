# Palette variants

The git-managed `gta6` install always tracks Vice Sunset. Create another palette as an independent local theme so switching colors never leaves the installed repository dirty.

Choose one:

```bash
~/.config/omarchy/themes/gta6/scripts/create-variant.sh ocean-drive
~/.config/omarchy/themes/gta6/scripts/create-variant.sh leonida-night
~/.config/omarchy/themes/gta6/scripts/create-variant.sh biscayne-day
```

The helper performs the following copy-out process. It only runs when invoked directly and refuses to overwrite an existing target:

```bash
variant="ocean-drive"
source_dir="$HOME/.config/omarchy/themes/gta6"
target_dir="$HOME/.config/omarchy/themes/gta6-$variant"

test -d "$source_dir/.git"
test ! -e "$target_dir"
mkdir -p "$target_dir"
git -C "$source_dir" archive HEAD | tar -x -C "$target_dir"
cp "$target_dir/variants/$variant.toml" "$target_dir/colors.toml"
omarchy theme set "gta6-$variant"
```

This exports the repository contents without its `.git` directory, applies the selected palette to the copy, and leaves the original install ready for `omarchy theme update`.

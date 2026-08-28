# Wallpaper editions

Vice Sunset remains the default `gta6` theme. Each additional edition pairs one supplied wallpaper with a palette drawn from that image, then adjusted for readable terminal and interface contrast.

| Edition | Wallpaper cue | Mode |
| --- | --- | --- |
| `all-stars` | Electric-blue getaway car | Dark |
| `safehouse-glow` | Coral bedroom window light | Dark |
| `leonida-blue` | Tropical water and open sky | Dark |
| `sunset-traffic` | Rose highway sunset | Dark |
| `city-highway` | Storm clouds and streetlight gold | Dark |
| `coastal-rider` | Green bike and white concrete | Light |
| `skyway-sunset` | Coral traffic glow | Dark |
| `getaway-heat` | Violet police light | Dark |
| `rooftop-pink` | Hot-pink palms and shirt | Dark |
| `jack-of-hearts` | Cool nightclub signage | Dark |
| `pink-getaway` | Saturated magenta cover art | Dark |
| `bullet-sunset` | Lavender skyline | Dark |
| `dockside-duo` | Bright water and coastal blue | Light |
| `gas-station-run` | Lilac dusk cover art | Dark |
| `beach-cover` | Coral evening sky | Dark |

Create and immediately select an edition after installing the base theme:

```bash
~/.config/omarchy/themes/gta6/scripts/create-variant.sh leonida-blue
```

The helper exports only that edition's palette and paired wallpaper into `~/.config/omarchy/themes/gta6-<edition>`. It runs only when invoked directly, never executes during theme installation, and refuses to overwrite an existing target. The original git-managed `gta6` theme remains clean for `omarchy theme update`.

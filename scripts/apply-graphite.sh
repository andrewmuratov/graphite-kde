#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ ${XDG_CURRENT_DESKTOP:-} != *KDE* && ${XDG_CURRENT_DESKTOP:-} != *Plasma* ]]; then
  echo "Warning: KDE Plasma not detected. Applying files only; KDE appearance may not update until a Plasma login."
fi
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.local/share/graphite-backups/$STAMP"
mkdir -p "$BACKUP" "$HOME/.local/share/color-schemes" "$HOME/.local/share/wallpapers/Graphite/contents/images" "$HOME/.config/ghostty/themes"
for f in "$HOME/.config/kdeglobals" "$HOME/.config/kwinrc" "$HOME/.config/ghostty/config"; do
  if [[ -f "$f" ]]; then cp -a "$f" "$BACKUP/$(basename "$f")"; fi
done
cp "$ROOT/themes/Graphite.colors" "$HOME/.local/share/color-schemes/Graphite.colors"
cp "$ROOT/wallpaper/graphite.svg" "$HOME/.local/share/wallpapers/Graphite/contents/images/1920x1080.svg"
cp "$ROOT/ghostty/graphite" "$HOME/.config/ghostty/themes/graphite"
if command -v kwriteconfig6 >/dev/null 2>&1; then
  kwriteconfig6 --file kdeglobals --group General --key ColorScheme Graphite
  kwriteconfig6 --file kdeglobals --group KDE --key LookAndFeelPackage org.kde.breezedark.desktop
  kwriteconfig6 --file kdeglobals --group Icons --key Theme breeze-dark
  kwriteconfig6 --file kdeglobals --group General --key Name Graphite
else
  echo "kwriteconfig6 not found; apply Graphite.colors manually in KDE System Settings."
fi
if command -v plasma-apply-colorscheme >/dev/null 2>&1; then
  plasma-apply-colorscheme Graphite || echo "Use System Settings > Colors > Graphite if needed."
fi
if command -v plasma-apply-wallpaperimage >/dev/null 2>&1; then
  plasma-apply-wallpaperimage "$HOME/.local/share/wallpapers/Graphite/contents/images/1920x1080.svg" || echo "Choose the Graphite wallpaper manually in Desktop Settings."
fi
printf '\nGraphite assets installed. Previous config backed up to: %s\n' "$BACKUP"
printf 'Ghostty: add `theme = graphite` to ~/.config/ghostty/config (after any existing theme line is removed).\n'
printf 'VS Code: merge vscode/settings.fragment.jsonc manually; existing settings were NOT overwritten.\n'
printf 'Sign out and back in if KDE does not refresh immediately.\n'

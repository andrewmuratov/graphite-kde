# Graphite KDE

> A dark, minimal, Linear-inspired desktop aesthetic for KDE Plasma, initially targeting Fedora KDE 44.

Graphite is an **independent, community-created design project**. It is not affiliated with Linear.

**Status: experimental / untested on Fedora 44.** Do not treat this as a stable release. The current kit installs a Plasma color scheme, wallpaper, and a Ghostty theme; panel layouts, login/lock screen, font installation and hardware tuning are not yet automated.

## Palette

| Token | Value |
| --- | --- |
| Background | `#0E0E10` |
| Surface | `#17171A` |
| Raised surface | `#1F1F23` |
| Border | `#29292E` |
| Text | `#EEEEF0` |
| Secondary text | `#92929A` |
| Accent | `#5E6AD2` |

## Install (after Fedora KDE is installed)

```bash
git clone https://github.com/andrewmuratov/graphite-kde.git
cd graphite-kde
bash scripts/apply-graphite.sh
```

Review scripts before executing them. The theme script backs up selected existing configuration files under `~/.local/share/graphite-backups/` and copies assets to user directories. It does **not** install packages, alter disks, change GPU drivers, or change encryption settings.

For development utilities, optionally run:

```bash
bash scripts/install-dependencies.sh
```

It prompts before executing `sudo dnf install`. Not needed for the visual theme.

### Manual finishing touches

- Under **System Settings → Colors**, select **Graphite** if it didn't activate automatically.
- Under desktop wallpaper settings, select the installed Graphite SVG if needed.
- In Ghostty, add `theme = graphite` after removing any previous theme directive.
- Merge `vscode/settings.fragment.jsonc` manually into your VS Code settings; **do not overwrite your existing file**.
- Keep effects minimal for a restrained appearance and lower compositor work.

## Restore

In **System Settings → Colors**, choose **Breeze Dark**. For fuller restoration, close affected applications, inspect the timestamped files in `~/.local/share/graphite-backups/` and manually copy back the prior configuration. The script does not yet provide an automated uninstaller.

## Diagnostics

```bash
bash scripts/diagnostics.sh
```

This writes `~/Documents/graphite-postinstall-check.txt`. Review it before sharing because it may contain system identifiers.

## Project structure

- `themes/Graphite.colors` — KDE color scheme
- `wallpaper/graphite.svg` — minimal SVG wallpaper
- `ghostty/graphite` — terminal palette
- `vscode/settings.fragment.jsonc` — optional editor appearance
- `scripts/apply-graphite.sh` — asset installer with configuration backups
- `scripts/install-dependencies.sh` — optional Fedora development packages
- `scripts/diagnostics.sh` — post-install diagnostics

## Safety and scope

Graphite intentionally avoids automatic firmware, TPM, bootloader, NVIDIA-driver, CPU/fan tuning, and partition changes. Test the Fedora KDE 44 live environment before replacing your existing OS, especially on older Intel/NVIDIA hybrid laptops.

## License

MIT. See [LICENSE](LICENSE).

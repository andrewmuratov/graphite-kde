#!/usr/bin/env bash
set -euo pipefail
if ! command -v dnf >/dev/null 2>&1; then echo 'Run this on Fedora Linux'; exit 1; fi
printf 'Will install basic KDE personalization and CS/math development tools.\n'
printf 'No bootloader, disk, power management or GPU driver changes will be made.\n'
read -r -p 'Proceed with DNF packages? [y/N] ' answer
[[ "$answer" =~ ^[Yy]$ ]] || exit 0
sudo dnf install -y git zsh curl wget unzip ripgrep fd-find fzf htop btop gcc gcc-c++ clang make cmake python3 python3-pip nodejs npm rust cargo texlive-scheme-basic latexmk lm_sensors smartmontools
printf '\nCore dependencies installed. VS Code, Ghostty and Lean are intentionally separate installs for verification.\n'

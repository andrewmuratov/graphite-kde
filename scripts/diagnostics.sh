#!/usr/bin/env bash
set -u
out="${HOME}/Documents/graphite-postinstall-check.txt"
mkdir -p "${HOME}/Documents"
{
 echo 'Graphite Fedora post-install diagnostics'; date -Is
 echo '=== OS ==='; cat /etc/os-release
 echo '=== Desktop ==='; echo "${XDG_CURRENT_DESKTOP:-unknown} ${XDG_SESSION_TYPE:-unknown}"
 echo '=== Kernel ==='; uname -r
 echo '=== Graphics ==='; lspci -nnk | grep -A 4 -Ei 'VGA compatible|3D controller' || true
 echo '=== GPU usage ==='; nvidia-smi 2>&1 || true
 echo '=== Battery ==='; upower -e 2>/dev/null | grep BAT || true
 echo '=== Power ==='; systemctl is-active tuned thermald tlp power-profiles-daemon 2>/dev/null || true
 echo '=== Temps ==='; sensors 2>&1 || true
 echo '=== Boot ==='; systemd-analyze 2>&1 || true
 echo '=== Errors ==='; journalctl -k -b -p err --no-pager 2>&1 | tail -35
} > "$out" 2>&1
printf 'Created %s (review private identifiers before uploading)\n' "$out"

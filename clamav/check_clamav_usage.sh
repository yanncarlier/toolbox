#!/usr/bin/env bash
# check_clamav_usage.sh
# Checks whether ClamAV is actually being used on a Debian/Ubuntu system.
# Usage: sudo ./check_clamav_usage.sh

set -uo pipefail

section() {
    echo
    echo "=== $1 ==="
}

section "1. Service status"
for svc in clamav-daemon clamav-freshclam clamav-milter; do
    if systemctl list-unit-files "${svc}.service" >/dev/null 2>&1 \
        && systemctl cat "${svc}.service" >/dev/null 2>&1; then
        printf '%-20s active=%s enabled=%s\n' "$svc" \
            "$(systemctl is-active "$svc" 2>/dev/null)" \
            "$(systemctl is-enabled "$svc" 2>/dev/null)"
    else
        printf '%-20s not installed\n' "$svc"
    fi
done

section "2. Running ClamAV processes"
pgrep -a -f 'clam|freshclam' || echo "No ClamAV processes running."

section "3. Virus definition files (should have recent dates)"
ls -l --time-style=long-iso /var/lib/clamav/ 2>/dev/null \
    || echo "Cannot read /var/lib/clamav/"

section "4. Recent scan activity in clamav.log"
if [[ -r /var/log/clamav/clamav.log ]]; then
    grep -Ei 'scan|found|OK|FOUND' /var/log/clamav/clamav.log | tail -n 15
    echo "(empty output above means no scans were logged)"
else
    echo "Cannot read /var/log/clamav/clamav.log (try running with sudo)."
fi

section "5. Recent freshclam updates"
if [[ -r /var/log/clamav/freshclam.log ]]; then
    tail -n 10 /var/log/clamav/freshclam.log
else
    echo "Cannot read /var/log/clamav/freshclam.log (try running with sudo)."
fi

section "6. Cron jobs or systemd timers referencing clam"
grep -ril 'clam' /etc/cron* /var/spool/cron 2>/dev/null \
    || echo "No cron entries mention clam."
systemctl list-timers --all 2>/dev/null | grep -i clam \
    || echo "No systemd timers mention clam."

section "7. Installed packages that depend on ClamAV"
apt-cache rdepends --installed clamav-daemon 2>/dev/null \
    || echo "Could not query reverse dependencies."

section "8. Shell history mentioning clamscan/clamdscan (current user)"
grep -E 'clamscan|clamdscan' ~/.bash_history 2>/dev/null | tail -n 10 \
    || echo "No manual scans found in history."

echo
echo "Done."
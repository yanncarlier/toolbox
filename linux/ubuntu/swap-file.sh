#!/bin/bash
# Adds an 8 GB swap file on Ubuntu and enables it permanently.
# Run with: sudo bash swap_setup.sh

set -e

SWAPFILE=/swapfile
SIZE=8G

if swapon --show | grep -q "$SWAPFILE"; then
    echo "Swap file already active."
    exit 0
fi

# Note: fallocate works on ext4/xfs. On btrfs, use a different method.
fallocate -l "$SIZE" "$SWAPFILE"
chmod 600 "$SWAPFILE"
mkswap "$SWAPFILE"
swapon "$SWAPFILE"

# Make it persist across reboots (only add once)
grep -q "^$SWAPFILE" /etc/fstab || echo "$SWAPFILE none swap sw 0 0" >> /etc/fstab

echo "Swap enabled:"
swapon --show
free -h
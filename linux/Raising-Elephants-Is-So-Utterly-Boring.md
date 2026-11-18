# Raising Elephants Is So Utterly Boring — Magic SysRq REISUB (In Order)

Extracted from `Raising-Elephants-Is-So-Utterly-Boring.jpg` (a photo of a screen/slide).

## What the image shows

**IN ORDER**

- **Alt + SysRq held** (the whole sequence is performed while holding Alt + SysRq)
- Press the following keys **in order**, waiting **~2 seconds** between each:

| Step | Key | Meaning |
|------|-----|---------|
| 1 | **R** | Switch keyboard from raw mode to XLATE (unraw) |
| 2 | **E** | Send SIGTERM to all processes (terminate) |
| 3 | **I** | Send SIGKILL to all remaining processes (kill) |
| 4 | **S** | Sync all filesystems (flush disk caches) |
| 5 | **U** | Remount all filesystems read-only |
| 6 | **B** | Reboot the machine immediately |

Timing shown between keys: `~2s` between R→E→I→S→U→B.

## Mnemonic

**R**aising **E**lephants **I**s **S**o **U**tterly **B**oring
(also commonly: *"Reboot Even If System Utterly Broken"*)

## What it is

The **Magic SysRq** sequence for safely rebooting a hung Linux system. Holding
`Alt + SysRq` and pressing the keys above, in order, flushes disks and remounts
filesystems read-only before rebooting, minimizing filesystem corruption.

- Linux only (requires `CONFIG_MAGIC_SYSRQ`, usually enabled).
- `SysRq` is often the `Print Screen` key.
- Check/enable via: `cat /proc/sys/kernel/sysrq` (a bitmask; `1` = all functions
  enabled, `0` = disabled). Set with `sysctl kernel.sysrq=1`.
- On some laptops you also need `Fn` (e.g. `Alt + Fn + SysRq + key`).

## Related resource

- Kernel docs: `Documentation/admin-guide/sysrq.rst` in the Linux source tree.

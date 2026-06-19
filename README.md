# LidHandler

Toggle laptop lid switch suspend behavior via systemd-logind drop-in configuration.

## What It Does

Prevents your laptop from suspending when you close the lid, using proper systemd drop-in files instead of modifying `/etc/systemd/logind.conf` directly.

## Quick Start

```bash
# Install (AUR - Arch Linux)
git clone https://aur.archlinux.org/lidhandler.git
cd lidhandler
makepkg -si

# Or install from source
sudo make install
```

## Usage

### Persistent Mode

```bash
sudo lidhandler enable    # Prevent suspend on lid close
sudo lidhandler disable   # Restore default suspend behavior
sudo lidhandler status    # Show current lid switch behavior
sudo lidhandler toggle    # Toggle (default if no args)
```

### Daemon Mode (Temporary)

Daemon mode holds a systemd-inhibit lock without modifying config files. The lock is released when the daemon stops.

```bash
sudo lidhandler daemon       # Run in foreground (Ctrl-C to stop)
sudo lidhandler daemon -d    # Run in background
sudo lidhandler daemon stop  # Stop background daemon
sudo lidhandler daemon status  # Check if daemon is running
```

## How It Works

**Persistent mode** creates a drop-in file at `/etc/systemd/logind.conf.d/10-lidhandler.conf`:

```ini
[Login]
HandleLidSwitch=ignore
```

**Daemon mode** uses `systemd-inhibit --what=handle-lid-switch` to temporarily block lid events. No config files are modified.

## Installation

### AUR (Arch Linux)

```bash
# From AUR
git clone https://aur.archlinux.org/lidhandler.git
cd lidhandler
makepkg -si
```

### Debian/Ubuntu (.deb)

```bash
# Build the .deb package
dpkg-deb --build pkg/deb lidhandler_1.0.0_all.deb

# Install
sudo dpkg -i lidhandler_1.0.0_all.deb
```

### RPM (Fedora/RHEL)

```bash
# Build the .rpm package
rpmbuild -ba pkg/rpm/lidhandler.spec

# Install
sudo rpm -i rpmbuild/RPMS/noarch/lidhandler-1.0.0-1.*.rpm
```

## Requirements

- systemd
- root/sudo access for toggle operations

## License

MIT

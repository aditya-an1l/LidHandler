<div align="center">
  <img src="https://raw.githubusercontent.com/aditya-an1l/LidHandler/main/media/logo.jpeg" width="200" height="200" alt="LidHandler Logo">
</div>

> **⚠️ Under Active Maintenance** — This project is undergoing heavy restructuring. Install scripts and packages may be broken or incomplete. Do not use in production until this notice is removed.
>
> **🛑 AUR publishing suspended.** On 2026-06-12, Arch Linux staff disclosed an active malicious-packages incident affecting the Arch User Repository[^aur-incident]. New account registration and package submission are blocked until further notice. The lidhandler AUR package (`pkg/aur/`) is prepared and tested; it will be pushed once the AUR reopens.
>
> [^aur-incident]: https://archlinux.org/news/active-aur-malicious-packages-incident/

<div align="center">
  <p>
    <a href="https://github.com/aditya-an1l/LidHandler/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/aditya-an1l/LidHandler?style=for-the-badge&logo=github&color=38bdf8&logoColor=FFFFFF&labelColor=0f172a&include_prerelease&sort=semver" />
    </a>
    <a href="https://github.com/aditya-an1l/LidHandler/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/aditya-an1l/LidHandler?style=for-the-badge&logo=git&color=38bdf8&logoColor=FFFFFF&labelColor=0f172a"/>
    </a>
    <a href="https://github.com/aditya-an1l/LidHandler/blob/main/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/aditya-an1l/LidHandler?style=for-the-badge&color=10b981&logoColor=FFFFFF&labelColor=0f172a"  />
    </a>
    <a href="https://github.com/aditya-an1l/LidHandler/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/aditya-an1l/LidHandler?style=for-the-badge&logo=starship&color=38bdf8&logoColor=FFFFFF&labelColor=0f172a" />
    </a>
    <a href="https://github.com/aditya-an1l/LidHandler/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/aditya-an1l/LidHandler?style=for-the-badge&color=f87171&logoColor=FFFFFF&labelColor=0f172a" />
    </a>
    <a href="https://github.com/aditya-an1l/LidHandler">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/aditya-an1l/LidHandler?color=38bdf8&label=SIZE&logo=files&style=for-the-badge&logoColor=FFFFFF&labelColor=0f172a" />
    </a>
    <a href="https://github.com/aditya-an1l/LidHandler">
      <img alt="Language" src="https://img.shields.io/badge/shell-POSIX%20sh-38bdf8?style=for-the-badge&logo=gnubash&logoColor=FFFFFF&labelColor=0f172a" />
    </a>
    <a href="https://github.com/aditya-an1l/LidHandler">
      <img alt="Platform" src="https://img.shields.io/badge/platform-Linux-10b981?style=for-the-badge&logo=linux&logoColor=FFFFFF&labelColor=0f172a" />
    </a>
  </p>
</div>

<br>

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
sudo lidhandler toggle    # Toggle
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

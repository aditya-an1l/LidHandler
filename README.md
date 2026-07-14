<div align="center">
  <img src="https://raw.githubusercontent.com/aditya-an1l/LidHandler/main/media/logo.jpeg" width="200" height="200" alt="LidHandler Logo">
</div>

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
# Fedora / RHEL / CentOS Stream (COPR — recommended)
sudo dnf copr enable aditya-an1l/lidhandler
sudo dnf install lidhandler

# Debian / Ubuntu (Launchpad PPA)
sudo add-apt-repository ppa:aditya-an1l/lidhandler
sudo apt update
sudo apt install lidhandler

# Arch Linux (AUR)
yay -S lidhandler
# or: paru -S lidhandler

# Or install from source (any distro)
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
yay -S lidhandler
# or: paru -S lidhandler
# or clone and build:
#   git clone https://aur.archlinux.org/lidhandler.git
#   cd lidhandler
#   makepkg -si
```

### Debian/Ubuntu (.deb)

```bash
# From Launchpad PPA (recommended)
sudo add-apt-repository ppa:aditya-an1l/lidhandler
sudo apt update
sudo apt install lidhandler
```

### RPM (Fedora / RHEL / CentOS Stream)

The recommended install is the published Fedora COPR repository — no local
build tooling required:

```bash
# Fedora
sudo dnf copr enable aditya-an1l/lidhandler
sudo dnf install lidhandler

# CentOS Stream / RHEL 9 (needs EPEL for `dnf copr`)
sudo dnf install epel-release
sudo dnf copr enable aditya-an1l/lidhandler
sudo dnf install lidhandler
```

Prefer to build the RPM yourself? The spec lives at `pkg/rpm/lidhandler.spec`:

```bash
rpmbuild -ba pkg/rpm/lidhandler.spec
sudo rpm -i ~/rpmbuild/RPMS/noarch/lidhandler-1.3.0-1.*.rpm
```

## Requirements

- systemd
- root/sudo access for toggle operations

## License

MIT

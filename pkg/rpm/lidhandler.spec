Name:           lidhandler
Version:        1.1.0
Release:        1%{?dist}
Summary:        Toggle laptop lid switch suspend behavior via systemd-logind

License:        MIT
URL:            https://github.com/aditya-an1l/LidHandler
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch
Requires:       systemd

%description
LidHandler manages laptop lid switch behavior using systemd-logind drop-in
configuration files. Prevent suspend-on-lid-close without modifying the
base logind.conf. Supports enable, disable, status, and toggle commands.

%prep
%setup -q

%build
# No build needed for shell scripts

%install
install -Dm755 src/lidhandler %{buildroot}/usr/bin/lidhandler
install -Dm644 config/lidhandler.conf %{buildroot}/etc/systemd/logind.conf.d/10-lidhandler.conf
install -Dm644 docs/lidhandler.1 %{buildroot}/usr/share/man/man1/lidhandler.1

%post
mkdir -p /etc/systemd/logind.conf.d
cat > /etc/systemd/logind.conf.d/10-lidhandler.conf <<'EOF'
[Login]
HandleLidSwitch=ignore
EOF
systemctl kill -s HUP systemd-logind 2>/dev/null || true
echo "LidHandler: Lid close will now be IGNORED (no suspend)"

%preun
rm -f /etc/systemd/logind.conf.d/10-lidhandler.conf
systemctl kill -s HUP systemd-logind 2>/dev/null || true
echo "LidHandler: Lid switch restored to default behavior"

%files
%license LICENSE
/usr/bin/lidhandler
/usr/share/man/man1/lidhandler.1
%config(noreplace) /etc/systemd/logind.conf.d/10-lidhandler.conf

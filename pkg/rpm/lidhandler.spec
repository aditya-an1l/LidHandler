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
%setup -q -n LidHandler-%{version}

%build
# No build needed for shell scripts

%install
install -Dm755 src/lidhandler %{buildroot}%{_bindir}/lidhandler
install -Dm644 config/lidhandler.conf %{buildroot}%{_sysconfdir}/systemd/logind.conf.d/10-lidhandler.conf
install -Dm644 docs/lidhandler.1 %{buildroot}%{_mandir}/man1/lidhandler.1
install -Dm644 LICENSE %{buildroot}%{_licensedir}/%{name}/LICENSE

%post
systemctl kill -s HUP systemd-logind 2>/dev/null || true

%preun
systemctl kill -s HUP systemd-logind 2>/dev/null || true

%files
%license %{_licensedir}/%{name}/LICENSE
%{_bindir}/lidhandler
%config(noreplace) %{_sysconfdir}/systemd/logind.conf.d/10-lidhandler.conf
%{_mandir}/man1/lidhandler.1*

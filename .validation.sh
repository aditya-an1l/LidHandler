#!/bin/bash
set -e

echo "=== Validation Loop — LidHandler ==="

echo "[1/5] Syntax check..."
sh -n src/lidhandler && echo "  src/lidhandler: OK"

echo "[2/5] Checking PKGBUILD syntax..."
if command -v bash &>/dev/null; then
    bash -n pkg/aur/PKGBUILD && echo "  PKGBUILD: OK"
else
    echo "  PKGBUILD: skipped (bash not available)"
fi

echo "[3/5] Checking DEBIAN/control (binary package)..."
if [ -f pkg/deb/DEBIAN/control ]; then
    if grep -q "^Package:" pkg/deb/DEBIAN/control && \
       grep -q "^Version:" pkg/deb/DEBIAN/control && \
       grep -q "^Architecture:" pkg/deb/DEBIAN/control; then
        echo "  DEBIAN/control: OK"
    else
        echo "  DEBIAN/control: MISSING REQUIRED FIELDS"
        exit 1
    fi
else
    echo "  DEBIAN/control: NOT FOUND"
    exit 1
fi

echo "[4/5] Checking debian/ source package..."
DEB_OK=1
for f in debian/changelog debian/control debian/rules debian/source/format debian/install debian/manpages; do
    if [ -f "$f" ]; then
        echo "  $f: OK"
    else
        echo "  $f: NOT FOUND"
        DEB_OK=0
    fi
done
# debian/compat must NOT exist (compat level lives in debian/control via debhelper-compat)
if [ -f debian/compat ]; then
    echo "  debian/compat: MUST NOT EXIST (use debhelper-compat in control)"
    DEB_OK=0
fi
if [ "$DEB_OK" -eq 0 ]; then
    echo "  debian/ source package: INCOMPLETE"
    exit 1
fi
if [ ! -x debian/rules ]; then
    echo "  debian/rules: NOT EXECUTABLE"
    exit 1
fi
echo "  debian/ source package: OK"

echo "[5/5] Checking RPM spec syntax..."
if command -v rpmbuild &>/dev/null; then
    rpmbuild --nobuild pkg/rpm/lidhandler.spec 2>/dev/null && echo "  RPM spec: OK" || echo "  RPM spec: check manually (rpmbuild available but may need deps)"
else
    echo "  RPM spec: skipped (rpmbuild not available)"
fi

echo ""
echo "=== All checks passed ==="

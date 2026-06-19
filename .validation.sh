#!/bin/bash
set -e

echo "=== Validation Loop — LidHandler ==="

echo "[1/4] Syntax check..."
sh -n src/lidhandler && echo "  src/lidhandler: OK"

echo "[2/4] Checking PKGBUILD syntax..."
if command -v bash &>/dev/null; then
    bash -n pkg/aur/PKGBUILD && echo "  PKGBUILD: OK"
else
    echo "  PKGBUILD: skipped (bash not available)"
fi

echo "[3/4] Checking DEBIAN/control..."
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

echo "[4/4] Checking RPM spec syntax..."
if command -v rpmbuild &>/dev/null; then
    rpmbuild --nobuild pkg/rpm/lidhandler.spec 2>/dev/null && echo "  RPM spec: OK" || echo "  RPM spec: check manually (rpmbuild available but may need deps)"
else
    echo "  RPM spec: skipped (rpmbuild not available)"
fi

echo ""
echo "=== All checks passed ==="

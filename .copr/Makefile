# .copr/Makefile for LidHandler SRPM build
# Invoked: make -f .copr/Makefile srpm spec=<path> outdir=<dir>
# Runs in a mock chroot with root privileges

PKG = $(shell grep "^Name:" "$(spec)" | awk '{ print $$2 }')
VER = $(shell grep "^Version:" "$(spec)" | awk '{ print $$2 }')
TARBALL = $(PKG)-$(VER).tar.gz
PREFIX = LidHandler-$(VER)

srpm:
	dnf -y install git rpm-build tar gzip
	mkdir -p "$(outdir)"
	git archive --format=tar --prefix="$(PREFIX)/" HEAD | gzip > "$(TARBALL)"
	rpmbuild -bs --nodeps \
		--define "_sourcedir $(CURDIR)" \
		--define "_srcrpmdir $(outdir)" \
		"$(spec)"

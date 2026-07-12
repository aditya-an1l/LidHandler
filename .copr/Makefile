# .copr/Makefile for LidHandler SRPM build
# Working directory is repo root when this runs

VERSION := 1.1.0

srpm:
	tar czf /tmp/lidhandler-$(VERSION).tar.gz \
		--transform="s|^./|lidhandler-$(VERSION)/|" \
		--exclude=.git \
		--exclude=.copr \
		.
	rpmbuild -bs \
		--define "_sourcedir /tmp" \
		--define "_srcrpmdir $(outdir)" \
		--nodeps \
		pkg/rpm/lidhandler.spec

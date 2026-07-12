# .copr/Makefile for LidHandler SRPM build
# This Makefile is used by COPR's make_srpm method

VERSION := 1.1.0

srpm:
	# Create source tarball from the checked-out repo
	tar czf /tmp/lidhandler-$(VERSION).tar.gz \
		--transform="s|^./|lidhandler-$(VERSION)/|" \
		--exclude=.git \
		-C $(outdir)/.. .
	# Copy spec to a location rpmbuild can find
	mkdir -p $(outdir)/SPECS
	cp pkg/rpm/lidhandler.spec $(outdir)/SPECS/
	# Build the SRPM
	rpmbuild -bs \
		--define "_sourcedir /tmp" \
		--define "_srcrpmdir $(outdir)" \
		--define "_specdir $(outdir)/SPECS" \
		--define "_topdir $(outdir)" \
		$(outdir)/SPECS/lidhandler.spec

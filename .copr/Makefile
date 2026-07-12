# .copr/Makefile for LidHandler SRPM build
# Invoked: make -f .copr/Makefile srpm spec=<path> outdir=<dir>

srpm:
	tar czf /tmp/lidhandler-1.1.0.tar.gz \
		--transform="s|^\./|LidHandler-1.1.0/|" \
		--exclude=.git \
		--exclude=.copr \
		.
	rpmbuild -bs \
		--define "_sourcedir /tmp" \
		--define "_srcrpmdir $(outdir)" \
		--define "_disable_source_fetch 1" \
		--nodeps \
		$(spec)

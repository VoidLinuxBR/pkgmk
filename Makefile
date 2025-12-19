PREFIX ?= /usr
BINDIR  = $(PREFIX)/bin
SHAREDIR = $(PREFIX)/share/pkgmk
DOCDIR = $(PREFIX)/share/doc/pkgmk

BIN_FILES = bin/pkgmake bin/pkgmake
SHARE_FILES = share/pkgmk/*.sh

all:
	@echo "Nada a compilar. Use: make install"

install:
	install -d $(DESTDIR)$(BINDIR)
	install -d $(DESTDIR)$(SHAREDIR)
	install -d $(DESTDIR)$(DOCDIR)

	install -m 755 $(BIN_FILES) $(DESTDIR)$(BINDIR)
	install -m 644 $(SHARE_FILES) $(DESTDIR)$(SHAREDIR)
	install -m 644 README.md $(DESTDIR)$(DOCDIR)/README.md

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/pkgmake
	rm -f $(DESTDIR)$(BINDIR)/pkgnew
	rm -rf $(DESTDIR)$(SHAREDIR)
	rm -rf $(DESTDIR)$(DOCDIR)

.PHONY: all install uninstall

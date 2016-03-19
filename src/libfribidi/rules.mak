# fribidi

FRIBIDI_VERSION := 0.19.7
FRIBIDI_URL := http://fribidi.org/download/fribidi-$(FRIBIDI_VERSION).tar.bz2

$(TARBALLS)/fribidi-$(FRIBIDI_VERSION).tar.bz2:
	$(call download,$(FRIBIDI_URL))

libfribidi: fribidi-$(FRIBIDI_VERSION).tar.bz2
	$(UNPACK)
	$(APPLY) $(SRC)/libfribidi/fribidi.patch
	$(APPLY) $(SRC)/libfribidi/no-ansi.patch
	$(MOVE)

.libfribidi: libfribidi
	$(RECONF)
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF)
	cd $< && $(MAKE) install
	touch $@

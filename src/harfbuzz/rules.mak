# HARFBUZZ

HARFBUZZ_VERSION := 1.2.3
HARFBUZZ_URL := http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-$(HARFBUZZ_VERSION).tar.bz2

HARFBUZZCONF = --with-icu=no --with-glib=no --with-fontconfig=yes

DEPSONLY += harfbuzz

$(TARBALLS)/harfbuzz-$(HARFBUZZ_VERSION).tar.bz2:
	$(call download,$(HARFBUZZ_URL))

harfbuzz: harfbuzz-$(HARFBUZZ_VERSION).tar.bz2
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.harfbuzz: harfbuzz .libfreetype .fontconfig
	cd $< && env NOCONFIGURE=1 sh autogen.sh
	cd $< && $(HOSTVARS) CFLAGS="$(CFLAGS)" ./configure $(HOSTCONF) $(HARFBUZZCONF)
	cd $< && $(MAKE) install
	touch $@

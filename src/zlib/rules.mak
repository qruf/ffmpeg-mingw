# zlib

ZLIB_VERSION := 1.2.8
ZLIB_URL := $(SF)/libpng/zlib-$(ZLIB_VERSION).tar.gz

$(TARBALLS)/zlib-$(ZLIB_VERSION).tar.gz:
	$(call download,$(ZLIB_URL))

zlib: zlib-$(ZLIB_VERSION).tar.gz
	$(UNPACK)
	$(APPLY) $(SRC)/zlib/mingw.patch
	$(MOVE)

.zlib: zlib
	cd $< && $(HOSTVARS) CFLAGS="$(CFLAGS)" ./configure --prefix=$(PREFIX) --static
	cd $< && $(MAKE) install
	touch $@

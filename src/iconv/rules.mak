# libiconv

ICONV_VERSION=1.14
ICONV_URL=$(GNU)/libiconv/libiconv-$(ICONV_VERSION).tar.gz

$(TARBALLS)/libiconv-$(ICONV_VERSION).tar.gz:
	$(call download,$(ICONV_URL))

iconv: libiconv-$(ICONV_VERSION).tar.gz
	$(UNPACK)
	$(APPLY) $(SRC)/iconv/win32.patch
	$(APPLY) $(SRC)/iconv/bins.patch
	$(APPLY) $(SRC)/iconv/iconv-c11.patch
ifdef HAVE_WIN64
	$(APPLY) $(SRC)/iconv/iconv-win64.patch
endif
	$(UPDATE_AUTOCONFIG) && cd $(UNPACK_DIR) && mv config.guess config.sub build-aux
	$(UPDATE_AUTOCONFIG) && cd $(UNPACK_DIR) && mv config.guess config.sub libcharset/build-aux
	$(MOVE)

.iconv: iconv
	cd $< && $(HOSTVARS) ./configure CFLAGS="$(CFLAGS) -fgnu89-inline" $(HOSTCONF) --disable-nls
	cd $< && $(MAKE) install
	touch $@

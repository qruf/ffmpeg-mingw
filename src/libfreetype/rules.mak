# freetype2

FREETYPE2_VERSION := 2.6.2
FREETYPE2_URL := $(SF)/freetype/freetype2/$(FREETYPE2_VERSION)/freetype-$(FREETYPE2_VERSION).tar.gz

FREETYPE_CONF := \
	--with-harfbuzz=no \
	--with-bzlib=yes \
	--with-zlib=yes \
	--without-png \
	$(FREETYPEOPTS)

$(TARBALLS)/freetype-$(FREETYPE2_VERSION).tar.gz:
	$(call download,$(FREETYPE2_URL))

libfreetype: freetype-$(FREETYPE2_VERSION).tar.gz
	$(UNPACK)
	$(call pkg_static, "builds/unix/freetype2.in")
	$(MOVE)
	cd $@ && cp builds/unix/install-sh .

.libfreetype: libfreetype .bzlib .zlib 
	sed -i.orig s/-ansi// $</builds/unix/configure 
	cd $< && GNUMAKE=$(MAKE) $(HOSTVARS) ./configure $(HOSTCONF) $(FREETYPE_CONF)
	cd $< && $(MAKE) && $(MAKE) install
	touch $@


# freetype2

FREETYPE2_VERSION := 2.6.2
FREETYPE2_URL := $(SF)/freetype/freetype2/$(FREETYPE2_VERSION)/freetype-$(FREETYPE2_VERSION).tar.gz

FREETYPE_CONF := \
	--with-harfbuzz=no \
	--with-zlib=yes \
	--without-png \
	--with-bzip2=no 

$(TARBALLS)/freetype-$(FREETYPE2_VERSION).tar.gz:
	$(call download,$(FREETYPE2_URL))

libfreetype: freetype-$(FREETYPE2_VERSION).tar.gz
	$(UNPACK)
	$(call pkg_static, "builds/unix/freetype2.in")
	$(MOVE)
	cd $@ && cp builds/unix/install-sh .

.libfreetype: libfreetype .zlib
	sed -i.orig s/-ansi// $</builds/unix/configure # why isn't this a fucking patch vlc
	cd $< && GNUMAKE=$(MAKE) $(HOSTVARS) ./configure $(HOSTCONF)
	cd $< && $(MAKE) && $(MAKE) install
	touch $@


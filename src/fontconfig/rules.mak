# fontconfig

FONTCONFIG_VERSION := 2.11.1
FONTCONFIG_URL := https://www.freedesktop.org/software/fontconfig/release/fontconfig-$(FONTCONFIG_VERSION).tar.gz

FONTCONFIG_CONF := $(HOSTCONF) \
	--enable-libxml2 \
	--disable-docs \
	--with-arch=$(ARCH) \
	--with-freetype-config="$(PREFIX)/bin/freetype-config"

$(TARBALLS)/fontconfig-$(FONTCONFIG_VERSION).tar.gz:
	$(call download,$(FONTCONFIG_URL))

fontconfig: fontconfig-$(FONTCONFIG_VERSION).tar.gz
	$(UNPACK)
	$(APPLY) $(SRC)/fontconfig/fontconfig-win32.patch
	$(APPLY) $(SRC)/fontconfig/fontconfig-noxml2.patch
	$(MOVE)

.fontconfig: fontconfig .libfreetype .libxml2
	$(RECONF)
	cd $< && $(HOSTVARS) ./configure $(FONTCONFIG_CONF)
	cd $< && $(MAKE)
	cd $< && $(MAKE) install
	touch $@


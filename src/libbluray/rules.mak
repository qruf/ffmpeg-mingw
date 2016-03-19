# libbluray

BLURAY_VERSION := 0.9.2
BLURAY_URL := $(VIDEOLAN)/libbluray/$(BLURAY_VERSION)/libbluray-$(BLURAY_VERSION).tar.bz2

BLURAY_CONF = --disable-examples  \
              --with-libxml2      \
              --enable-udf        \
			  --disable-bdjava

$(TARBALLS)/libbluray-$(BLURAY_VERSION).tar.bz2:
	$(call download,$(BLURAY_URL))

libbluray: libbluray-$(BLURAY_VERSION).tar.bz2
	$(UNPACK)
	$(MOVE)

.libbluray: libbluray .libxml2 .libfreetype
	cd $< && ./bootstrap
	cd $< && $(HOSTVARS) ./configure $(BLURAY_CONF) $(HOSTCONF)
	cd $< && $(MAKE) install
	touch $@

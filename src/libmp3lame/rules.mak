# lame

LAME_VERSION := 3.99.5
LAME_URL := $(SF)/lame/lame-$(LAME_VERSION).tar.gz

LAME_CONF := --disable-analyzer-hooks \
	--disable-decoder \
	--disable-gtktest \
	--disable-frontend

$(TARBALLS)/libmp3lame-$(LAME_VERSION).tar.gz:
	$(call download,$(LAME_URL))

libmp3lame: libmp3lame-$(LAME_VERSION).tar.gz
	$(UNPACK)
	$(APPLY) $(SRC)/libmp3lame/lame-forceinline.patch
	$(APPLY) $(SRC)/libmp3lame/sse.patch
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.libmp3lame: libmp3lame
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(LAME_CONF)
	cd $< && $(MAKE) install
	touch $@

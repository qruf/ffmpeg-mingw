# libogg

OGG_VERSION := 1.3.2
OGG_URL := http://downloads.xiph.org/releases/ogg/libogg-$(OGG_VERSION).tar.xz

DEPSONLY += ogg

$(TARBALLS)/ogg-$(OGG_VERSION).tar.xz:
	$(call download,$(OGG_URL))

ogg: ogg-$(OGG_VERSION).tar.xz
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.ogg: ogg
	$(RECONF)
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(OGGOPTS)
	cd $< && $(MAKE) install
	touch $@

# modplug

MODPLUG_VERSION := 0.8.8.5
MODPLUG_URL := $(SF)/modplug-xmms/libmodplug-$(MODPLUG_VERSION).tar.gz

$(TARBALLS)/libmodplug-$(MODPLUG_VERSION).tar.gz:
	$(call download,$(MODPLUG_URL))

libmodplug: libmodplug-$(MODPLUG_VERSION).tar.gz
	$(UNPACK)
	$(APPLY) $(SRC)/libmodplug/modplug-win32-static.patch
	$(call pkg_static,"libmodplug.pc.in")
	$(MOVE)

.libmodplug: libmodplug
	$(RECONF)
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF)
	cd $< && $(MAKE) install
	touch $@

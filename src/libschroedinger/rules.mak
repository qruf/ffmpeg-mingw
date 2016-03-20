# schroedinger

SCHROEDINGER_VERSION := 1.0.11
SCHROEDINGER_URL := $(CONTRIB_VIDEOLAN)/schroedinger-$(SCHROEDINGER_VERSION).tar.gz

SCHROEDINGERCONF := \
	--with-thread=pthread \
	--disable-gtk-doc \
	$(SCHROEDINGEROPTS)

$(TARBALLS)/libschroedinger-$(SCHROEDINGER_VERSION).tar.gz:
	$(call download,$(SCHROEDINGER_URL))

libschroedinger: libschroedinger-$(SCHROEDINGER_VERSION).tar.gz
	$(UNPACK)
	$(APPLY) $(SRC)/libschroedinger/schroedinger-notests.patch
	$(MOVE)

.libschroedinger: libschroedinger .orc
	$(RECONF)
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(SCHROEDINGERCONF)
	cd $< && $(MAKE) install
	touch $@

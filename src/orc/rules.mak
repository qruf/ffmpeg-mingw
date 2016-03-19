# orc

ORC_VERSION := 0.4.18
ORC_URL := $(CONTRIB_VIDEOLAN)/orc-$(ORC_VERSION).tar.gz

DEPSONLY += orc

ORCCONF := \
	--enable-backend=sse,mmx \
	$(ORCOPTS)

$(TARBALLS)/orc-$(ORC_VERSION).tar.gz:
	$(call download,$(ORC_URL))

orc: orc-$(ORC_VERSION).tar.gz 
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.orc: orc
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(ORCOPTS)
	cd $< && $(MAKE) install
	touch $@

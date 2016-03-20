# lzma

LZMA_VERSION := 5.2.2
LZMA_URL := http://tukaani.org/xz/xz-$(LZMA_VERSION).tar.xz

$(TARBALLS)/xz-$(LZMA_VERSION).tar.xz:
	$(call download,$(LZMA_URL))

lzma: xz-$(LZMA_VERSION).tar.xz 
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.lzma: lzma
	cd $< && ./configure $(HOSTCONF) $(LZMAOPTS)
	cd $</src/liblzma && $(MAKE) $(HOSTVARS) install
	touch $@


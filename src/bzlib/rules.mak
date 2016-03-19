# bzlib

BZLIB_VERSION := 1.0.6
BZLIB_URL := http://bzip.org/$(BZLIB_VERSION)/bzip2-$(BZLIB_VERSION).tar.gz

$(TARBALLS)/bzlib-$(BZLIB_VERSION).tar.gz:
	$(call download,$(BZLIB_URL))

bzlib: bzlib-$(BZLIB_VERSION).tar.gz 
	$(UNPACK)
	$(MOVE)

.bzlib: bzlib
	cd $< && $(MAKE) $(HOSTVARS) libbz2.a
	mkdir -p $(PREFIX)/lib $(PREFIX)/include
	cd $< && cp -f libbz2.a $(PREFIX)/lib
	cd $< && cp -f bzlib.h $(PREFIX)/include
	chmod a+r $(PREFIX)/lib/libbz2.a
	chmod a+r $(PREFIX)/include/bzlib.h
	touch $@


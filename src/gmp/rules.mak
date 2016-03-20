# GNU Multiple Precision Arithmetic

GMP_VERSION := 6.1.0
GMP_URL := https://gmplib.org/download/gmp-$(GMP_VERSION)/gmp-$(GMP_VERSION).tar.xz

ENABLE_GPL3 := 1

$(TARBALLS)/gmp-$(GMP_VERSION).tar.xz:
	$(call download,$(GMP_URL))

gmp: gmp-$(GMP_VERSION).tar.xz
	$(UNPACK)
	$(MOVE)

.gmp: gmp
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(GMPOPTS)
	cd $< && $(MAKE) install
	touch $@

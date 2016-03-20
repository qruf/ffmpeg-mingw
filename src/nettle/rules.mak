# Nettle

NETTLE_VERSION := 2.7.1
NETTLE_URL := ftp://ftp.gnu.org/gnu/nettle/nettle-$(NETTLE_VERSION).tar.gz

NETTLECONF := \
	--disable-pic \
	--disable-documentation \
	$(NETTLEOPTS)	

DEPSONLY += nettle

$(TARBALLS)/nettle-$(NETTLE_VERSION).tar.gz:
	$(call download,$(NETTLE_URL))

nettle: nettle-$(NETTLE_VERSION).tar.gz
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.nettle: nettle .gmp
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(NETTLECONF) 
	cd $< && $(MAKE) install-static install-headers install-pkgconfig
	touch $@

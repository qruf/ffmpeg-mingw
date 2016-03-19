# GnuTLS

GNUTLS_VERSION := 3.3.22
GNUTLS_URL := ftp://ftp.gnutls.org/gcrypt/gnutls/v$(basename $(GNUTLS_VERSION))/gnutls-$(GNUTLS_VERSION).tar.xz

GNUTLS_CONF := \
	--disable-gtk-doc \
	--without-p11-kit \
	--disable-cxx \
	--disable-srp-authentication \
	--disable-psk-authentication-FIXME \
	--disable-anon-authentication \
	--disable-openpgp-authentication \
	--disable-openssl-compatibility \
	--disable-guile \
	--disable-nls \
	--without-libintl-prefix \
	--disable-doc \
	--disable-tests \

$(TARBALLS)/gnutls-$(GNUTLS_VERSION).tar.xz:
	$(call download,$(GNUTLS_URL))

gnutls: gnutls-$(GNUTLS_VERSION).tar.xz
	$(UNPACK)
	$(APPLY) $(SRC)/gnutls/gnutls-win32.patch
	$(APPLY) $(SRC)/gnutls/read-file-limits.h.patch
	$(APPLY) $(SRC)/gnutls/mac-keychain-lookup.patch
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.gnutls: gnutls .nettle
	$(RECONF)
	cd $< && $(HOSTVARS) ./configure $(GNUTLS_CONF) $(HOSTCONF)
	cd $</gl && $(MAKE) install
	cd $</lib && $(MAKE) install
	touch $@

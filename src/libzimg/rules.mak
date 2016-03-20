# libzimg

ZIMG_VERSION := 2.0.4
ZIMG_URL := https://github.com/sekrit-twc/zimg/archive/release-$(ZIMG_VERSION).tar.gz
ZIMG_SNAPURL := https://github.com/sekrit-twc/zimg/archive/master.tar.gz

ZIMGCONF := \
	--enable-x86simd \
	$(ZIMGOPTS)

$(TARBALLS)/zimg-$(ZIMG_VERSION).tar.gz:
	$(call download,$(ZIMG_URL))

$(TARBALLS)/zimg-git.tar.gz:
	$(call download,$(ZIMG_SNAPURL))

libzimg: zimg-$(ZIMG_VERSION).tar.gz
	$(UNPACK)
	$(APPLY) $(SRC)/libzimg/zimg-pkgconfig.patch
	$(MOVE)
	$(AUTOGEN)

libzimg-git: zimg-git.tar.gz
	$(UNPACK)
	$(APPLY) $(SRC)/libzimg/zimg-pkgconfig.patch
	$(MOVE)
	$(AUTOGEN)

.libzimg: $(filter libzimg%,$(PKGS))
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(ZIMGCONF)
	cd $< && $(MAKE) install
	touch $@


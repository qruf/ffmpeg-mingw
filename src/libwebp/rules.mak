# libwebp

WEBP_VERSION := 0.5.0
WEBP_URL := http://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-$(WEBP_VERSION).tar.gz
WEBP_BRANCH := master
WEBP_GITURL := https://github.com/webmproject/libwebp/archive/$(WEBP_BRANCH).tar.gz

$(TARBALLS)/libwebp-$(WEBP_VERSION).tar.gz:
	$(call download,$(WEBP_URL))

$(TARBALLS)/libwebp-git.tar.gz:
	$(call download,$(WEBP_GITURL))

libwebp: libwebp-$(WEBP_VERSION).tar.gz
	$(UNPACK)
	$(MOVE)
	$(AUTOGEN)

libwebp-git: libwebp-git.tar.gz
	$(UNPACK)
	$(MOVE)
	$(AUTOGEN)

.libwebp: $(filter libwebp%,$(PKGS))
	cd $< && ./configure $(HOSTCONF) $(WEBPOPTS)
	cd $< && $(MAKE) $(HOSTVARS) install
	touch $@

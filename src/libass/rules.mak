# libass

ASS_VERSION := 0.13.2
ASS_URL := https://github.com/libass/libass/releases/download/$(ASS_VERSION)/libass-$(ASS_VERSION).tar.xz
ASS_BRANCH := master
ASS_GITURL := https://github.com/libass/libass/archive/$(ASS_BRANCH).tar.gz

ASS_CONF=--disable-enca $(ASSOPTS)

ifndef DEBUG
ASS_CFLAGS += -O3
else
ASS_CFLAGS += -g
endif

$(TARBALLS)/libass-$(ASS_VERSION).tar.xz:
	$(call download,$(ASS_URL))

$(TARBALLS)/libass-git.tar.gz:
	$(call download,$(ASS_GITURL))

libass: libass-$(ASS_VERSION).tar.xz
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

libass-git: libass-git.tar.gz
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)
	$(AUTOGEN)

.libass: $(filter libass%,$(PKGS)) .libfreetype .libfribidi .fontconfig .harfbuzz
	cd $< && $(HOSTVARS) CFLAGS="$(CFLAGS) $(ASS_CFLAGS)" ./configure $(HOSTCONF) $(ASS_CONF)
	cd $< && $(MAKE) install
	touch $@

# theora

THEORA_VERSION := 1.1.1
THEORA_URL := http://downloads.xiph.org/releases/theora/libtheora-$(THEORA_VERSION).tar.xz
THEORA_BRANCH := master
THEORA_GITURL := https://git.xiph.org/?p=theora.git;a=snapshot;h=refs/heads/$(THEORA_BRANCH);sf=tgz

THEORACONF := \
	--disable-spec \
	--disable-sdltest \
	--disable-oggtest \
	--disable-vorbistest \
	--disable-examples \
	$(THEORAOPTS)

ifdef HAVE_WIN64
THEORACONF += --disable-asm
endif

$(TARBALLS)/libtheora-$(THEORA_VERSION).tar.xz:
	$(call download,$(THEORA_URL))

$(TARBALLS)/libtheora-git.tar.gz:
	$(call download,$(THEORA_GITURL))

libtheora: libtheora-$(THEORA_VERSION).tar.xz 
	$(UNPACK)
	$(APPLY) $(SRC)/libtheora/libtheora-compiler-differentiation.patch
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

libtheora-git: libtheora-git.tar.gz 
	$(UNPACK)
	$(APPLY) $(SRC)/libtheora/libtheora-compiler-differentiation.patch
	$(UPDATE_AUTOCONFIG)
	$(MOVE)
	$(AUTOGEN) $(THEORACONF)

.libtheora: $(filter libtheora%,$(PKGS)) .ogg
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(THEORACONF)
	cd $< && $(MAKE) install
	touch $@

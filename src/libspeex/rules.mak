# speex

SPEEX_VERSION := 1.2rc2
SPEEX_URL := http://downloads.xiph.org/releases/speex/speex-$(SPEEX_VERSION).tar.gz
SPEEX_BRANCH := master
SPEEX_GITURL := https://git.xiph.org/?p=speex.git;a=snapshot;h=refs/heads/$(VORBIS_BRANCH);sf=tgz

SPEEX_CONF := --disable-binaries

$(TARBALLS)/libspeex-$(SPEEX_VERSION).tar.gz:
	$(call download,$(SPEEX_URL))

$(TARBALLS)/libspeex-git.tar.gz:
	$(call download,$(SPEEX_GITURL))

libspeex: libspeex-$(SPEEX_VERSION).tar.gz 
	$(UNPACK)
	$(MOVE)

libspeex-git: libspeex-git.tar.gz 
	$(UNPACK)
	$(MOVE)
	$(AUTOGEN)

.libspeex: $(filter libspeex%,$(PKGS))
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(SPEEX_CONF)
	cd $< && $(MAKE) install
	touch $@

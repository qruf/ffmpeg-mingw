# libvorbis

VORBIS_VERSION := 1.3.5
VORBIS_URL := http://downloads.xiph.org/releases/vorbis/libvorbis-$(VORBIS_VERSION).tar.xz
VORBIS_BRANCH := master
VORBIS_GITURL := https://git.xiph.org/?p=vorbis.git;a=snapshot;h=refs/heads/$(VORBIS_BRANCH);sf=tgz

VORBISCONF := --disable-docs --disable-examples --disable-oggtest $(VORBISOPTS)

$(TARBALLS)/libvorbis-$(VORBIS_VERSION).tar.xz:
	$(call download,$(VORBIS_URL))

$(TARBALLS)/libvorbis-git.tar.gz:
	$(call download,$(VORBIS_GITURL))

libvorbis: libvorbis-$(VORBIS_VERSION).tar.xz
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

libvorbis-git: libvorbis-git.tar.gz
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)
	$(AUTOGEN)

.libvorbis: $(filter libvorbis%,$(PKGS)) .ogg
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(VORBISCONF)
	cd $< && $(MAKE) install
	touch $@

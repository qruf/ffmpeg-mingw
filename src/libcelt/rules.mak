# celt

CELT_VERSION := 0.11.3
CELT_URL := http://downloads.xiph.org/releases/celt/celt-$(CELT_VERSION).tar.gz
CELT_BRANCH := master
CELT_GITURL := https://git.xiph.org/?p=celt.git;a=snapshot;h=refs/heads/$(CELT_BRANCH);sf=tgz

CELT_CONF := --disable-binaries

$(TARBALLS)/libcelt-$(CELT_VERSION).tar.gz:
	$(call download,$(CELT_URL))

$(TARBALLS)/libcelt-git.tar.gz:
	$(call download,$(CELT_GITURL))

libcelt: libcelt-$(CELT_VERSION).tar.gz 
	$(UNPACK)
	$(MOVE)

libcelt-git: libcelt-git.tar.gz 
	$(UNPACK)
	$(MOVE)

.libcelt: $(filter libcelt%,$(PKGS)) .ogg
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(CELT_CONF)
	cd $< && $(MAKE) install
	touch $@

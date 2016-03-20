# opus

OPUS_VERSION := 1.1.2
OPUS_URL := http://downloads.xiph.org/releases/opus/opus-$(OPUS_VERSION).tar.gz
OPUS_BRANCH := master
OPUS_GITURL := https://git.xiph.org/?p=opus.git;a=snapshot;h=refs/heads/$(OPUS_BRANCH);sf=tgz

OPUS_CONF := \
	--disable-extra-programs \
	--disable-doc \
	$(OPUSOPTS)

$(TARBALLS)/opus-$(OPUS_VERSION).tar.gz:
	$(call download,$(OPUS_URL))

$(TARBALLS)/opus-git.tar.gz:
	$(call download,$(OPUS_GITURL))

libopus: opus-$(OPUS_VERSION).tar.gz
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

libopus-git: opus-git.tar.gz
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)
	$(AUTOGEN)

.libopus: $(filter libopus%,$(PKGS))
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(OPUS_CONF)
	cd $< && $(MAKE) install
	touch $@

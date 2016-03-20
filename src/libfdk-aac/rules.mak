# fdk-aac

FDK_VERSION := 0.1.4
FDK_URL := https://github.com/mstorsjo/fdk-aac/archive/v$(FDK_VERSION).tar.gz
FDK_BRANCH := master
FDK_GITURL := https://github.com/mstorsjo/fdk-aac/archive/$(FDK_BRANCH).tar.gz

ENABLE_NONFREE := 1

$(TARBALLS)/libfdk-aac-$(FDK_VERSION).tar.gz:
	$(call download,$(FDK_URL))

$(TARBALLS)/libfdk-aac-git.tar.gz:
	$(call download,$(FDK_GITURL))

libfdk-aac: libfdk-aac-$(FDK_VERSION).tar.gz
	$(UNPACK)
	$(MOVE)
	$(AUTOGEN)

libfdk-aac-git: libfdk-aac-git.tar.gz
	$(UNPACK)
	$(MOVE)
	$(AUTOGEN)

.libfdk-aac: $(filter libfdk-aac%,$(PKGS))
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(FDKOPTS)
	cd $< && $(MAKE) install
	touch $@

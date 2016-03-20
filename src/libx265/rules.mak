# x265

X265_VERSION := 1.9
X265_URL := https://bitbucket.org/multicoreware/x265/get/$(X265_VERSION).tar.bz2
X265_BRANCH := stable
X265_GITURL := https://bitbucket.org/multicoreware/x265/get/$(X265_BRANCH).tar.bz2

X265CONF := \
	-DENABLE_SHARED=OFF \
	-DENABLE_CLI=OFF \
	$(X265OPTS)

ENABLE_GPL := 1

$(TARBALLS)/x265-$(X265_VERSION).tar.bz2:
	$(call download,$(X265_URL))

$(TARBALLS)/x265-git.tar.bz2:
	$(call download,$(X265_GITURL))

libx265: x265-$(X265_VERSION).tar.bz2
	$(UNPACK)
	$(MOVE)

libx265-git: x265-git.tar.bz2
	$(UNPACK)
	$(MOVE)

.libx265: $(filter libx265%,$(PKGS)) toolchain.cmake
	cd $</source && $(HOSTVARS) $(CMAKE) $(X265CONF)
	cd $</source && $(MAKE) install
	touch $@


# libvpx

VPX_VERSION := 1.5.0
VPX_URL := http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-$(VPX_VERSION).tar.bz2
VPX_BRANCH := master
VPX_GITURL := https://github.com/webmproject/libvpx/archive/$(VPX_BRANCH).tar.gz

ifeq ($(ARCH),i386)
VPX_TARGET := x86-win32-gcc
else ifeq ($(ARCH),x86_64)
VPX_TARGET := x86_64-win64-gcc
endif

VPX_CONF := \
	--prefix=$(PREFIX) \
	--enable-runtime-cpu-detect \
	--disable-docs \
	--disable-examples \
	--disable-unit-tests \
	--disable-install-bins \
	--disable-install-docs \
	--target=$(VPX_TARGET) \
	$(VPXOPTS)

$(TARBALLS)/libvpx-$(VPX_VERSION).tar.bz2:
	$(call download,$(VPX_URL))

$(TARBALLS)/libvpx-git.tar.gz:
	$(call download,$(VPX_GITURL))

libvpx: libvpx-$(VPX_VERSION).tar.bz2
	$(UNPACK)
	$(MOVE)

libvpx-git: libvpx-git.tar.gz
	$(UNPACK)
	$(MOVE)

.libvpx: $(filter libvpx%,$(PKGS))
	cd $< && CROSS=$(HOST)- ./configure $(VPX_CONF)
	cd $< && $(MAKE)
	cd $< && ../../src/pkg-static.sh vpx.pc
	cd $< && $(MAKE) install
	touch $@

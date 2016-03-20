# mfx_dispatch

MFX_BRANCH := master
MFX_GITURL := https://github.com/lu-zero/mfx_dispatch/archive/$(MFX_BRANCH).tar.gz

$(TARBALLS)/libmfx-git.tar.gz:
	$(call download,$(MFX_GITURL))

libmfx: libmfx-git.tar.gz
	$(UNPACK)
	$(MOVE)

libmfx-git: libmfx

.libmfx: libmfx
	$(RECONF)
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) $(MFXOPTS)
	cd $< && $(MAKE) install
	touch $@

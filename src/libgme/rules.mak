# Game Music Emu

GME_VERSION := 0.6.0
GME_URL := https://bitbucket.org/mpyne/game-music-emu/downloads/game-music-emu-$(GME_VERSION).tar.bz2
GME_BRANCH := master
GME_GITURL := https://bitbucket.org/mpyne/game-music-emu/get/$(GME_BRANCH).tar.bz2

GMECONF := -DBUILD_SHARED_LIBS=OFF $(GMEOPTS)

$(TARBALLS)/libgme-$(GME_VERSION).tar.bz2:
	$(call download,$(GME_URL))

$(TARBALLS)/libgme-git.tar.bz2:
	$(call download,$(GME_GITURL))

libgme: libgme-$(GME_VERSION).tar.bz2
	$(UNPACK)
	$(APPLY) $(SRC)/libgme/gme-quotes.patch
	$(APPLY) $(SRC)/libgme/skip-underrun.patch
	$(MOVE)

libgme-git: libgme-git.tar.bz2
	$(UNPACK)
	$(APPLY) $(SRC)/libgme/gme-quotes.patch
	$(APPLY) $(SRC)/libgme/skip-underrun.patch
	$(MOVE)

.libgme: $(filter libgme%,$(PKGS)) toolchain.cmake
	cd $< && $(HOSTVARS) $(CMAKE) . $(GMECONF) 
	cd $< && $(MAKE) install
	touch $@

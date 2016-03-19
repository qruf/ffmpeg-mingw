# libxvid

XVID_VERSION := 1.3.4
XVID_URL := http://downloads.xvid.org/downloads/xvidcore-$(XVID_VERSION).tar.gz
# XVID_GITURL := http://downloads.xvid.org/downloads/xvid_latest.tar.gz

ENABLE_GPL := 1

$(TARBALLS)/libxvid-$(XVID_VERSION).tar.gz:
	$(call download,$(XVID_URL))

# $(TARBALLS)/libxvid-git.tar.gz:
# 	$(call download,$(XVID_GITURL))

libxvid: libxvid-$(XVID_VERSION).tar.gz
	$(UNPACK)
	$(APPLY) $(SRC)/libxvid/libxvid-nosharedlib.patch
	$(MOVE)

# libxvid-git: libxvid-git.tar.gz
# 	$(UNPACK) trunk/xvidcore
# 	$(APPLY) $(SRC)/libxvid/libxvid-nosharedlib.patch
# 	$(MOVE)

.libxvid: $(filter libxvid%,$(PKGS))
	cd $</build/generic && ./configure $(HOSTCONF)
	cd $</build/generic && $(HOSTVARS) $(MAKE) && $(MAKE) install
	touch $@

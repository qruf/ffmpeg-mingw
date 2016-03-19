# frei0r

FREI0R_VERSION := 1.4
FREI0R_URL := https://files.dyne.org/frei0r/releases/frei0r-plugins-$(FREI0R_VERSION).tar.gz
FREI0R_BRANCH := master
FREI0R_GITURL := https://github.com/ddennedy/frei0r/archive/$(FREI0R_BRANCH).tar.gz

ENABLE_GPL := 1

$(TARBALLS)/frei0r-$(FREI0R_VERSION).tar.gz:
	$(call download,$(FREI0R_URL))

$(TARBALLS)/frei0r-git.tar.gz:
	$(call download,$(FREI0R_GITURL))

frei0r: frei0r-$(FREI0R_VERSION).tar.gz
	$(UNPACK)
	$(MOVE)

frei0r-git: frei0r-git.tar.gz
	$(UNPACK)
	$(MOVE)
	$(AUTOGEN)

.frei0r: $(filter frei0r%,$(PKGS))
	mkdir -p $(PREFIX)/include
	mv $</include/frei0r.h $(PREFIX)/include
	touch $@

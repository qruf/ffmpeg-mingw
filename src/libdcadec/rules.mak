# libdcadec

DCADEC_VERSION := 0.2.0
DCADEC_URL := https://github.com/foo86/dcadec/archive/v$(DCADEC_VERSION).tar.gz
DCADEC_BRANCH := master
DCADEC_GITURL := https://github.com/foo86/dcadec/archive/$(DCADEC_BRANCH).tar.gz

$(TARBALLS)/libdcadec-$(DCADEC_VERSION).tar.gz:
	$(call download,$(DCADEC_URL))

$(TARBALLS)/libdcadec-git.tar.gz:
	$(call download,$(DCADEC_GITURL))

libdcadec: libdcadec-$(DCADEC_VERSION).tar.gz
	$(UNPACK)
	$(MOVE)

libdcadec-git: libdcadec-git.tar.gz
	$(UNPACK)
	$(MOVE)

.libdcadec: $(filter libdcadec%,$(PKGS))
	cd $< && $(HOSTVARS) $(MAKE) install-lib
	touch $@

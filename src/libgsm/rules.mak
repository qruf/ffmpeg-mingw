# GSM
GSM_VERSION := 1.0.13
GSM_URL := $(CONTRIB_VIDEOLAN)/libgsm_$(GSM_VERSION).tar.gz

$(TARBALLS)/libgsm_$(GSM_VERSION).tar.gz:
	$(call download,$(GSM_URL))

libgsm: libgsm_$(GSM_VERSION).tar.gz
	$(UNPACK)
	$(APPLY) $(SRC)/libgsm/gsm-makefile.patch
	$(MOVE)

.libgsm: libgsm
	cd $< && $(HOSTVARS) $(MAKE) gsminstall
	touch $@

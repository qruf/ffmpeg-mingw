# x264

X264_GITURL := http://ftp.videolan.org/pub/videolan/x264/snapshots/last_stable_x264.tar.bz2

X264CONF = --prefix="$(PREFIX)" --host="$(HOST)" --cross-prefix="$(HOST)-" \
	--enable-static \
	--disable-avs \
	--disable-lavf \
	--disable-cli \
	--disable-ffms \
	$(X264OPTS)

ENABLE_GPL := 1

$(TARBALLS)/x264-git.tar.bz2:
	$(call download,$(X264_GITURL))

libx264: x264-git.tar.bz2
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

libx264-git: libx264

.libx264: libx264
	cd $< && $(HOSTVARS) ./configure $(X264CONF)
	cd $< && $(MAKE) install
	touch $@

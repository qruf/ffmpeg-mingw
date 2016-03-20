# FFmpeg

FFMPEG_VERSION := 3.0
FFMPEG_URL := http://ffmpeg.org/releases/ffmpeg-3.0.tar.xz
FFMPEG_GITURL := http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2

FFMPEGCONF := \
	--cross-prefix=$(HOST)- \
	--target-os=mingw32 --disable-w32threads \
	--enable-static --disable-shared \
	--extra-ldflags="-Wl,-Bstatic -static-libgcc -static-libstdc++" \
	--pkg-config="$(PKG_CONFIG) --static" \
 	--disable-doc \
	--disable-debug \
	$(FFMPEGOPTS) \
	$(TARGETS:.%=--enable-%)

ifdef ENABLE_GPL
FFMPEGCONF += --enable-gpl
endif
ifdef ENABLE_GPL3
FFMPEGCONF += --enable-version3
endif
ifdef ENABLE_NONFREE
FFMPEGCONF += --enable-nonfree
endif
ifdef DEBUG
FFMPEGCONF += --optflags=-O0
endif

ifeq ($(ARCH),i386)
FFMPEGCONF += --arch=x86
else ifeq ($(ARCH),x86_64)
FFMPEGCONF += --arch=x86_64
endif

ifndef HAVE_MINGW_W64
TARGETS += .directx
endif

$(TARBALLS)/ffmpeg-$(FFMPEG_VERSION).tar.xz:
	$(call download,$(FFMPEG_URL))

$(TARBALLS)/ffmpeg-git.tar.bz2:
	$(call download,$(FFMPEG_GITURL))

ffmpeg: ffmpeg-$(FFMPEG_VERSION).tar.xz
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

ffmpeg-git: ffmpeg-git.tar.bz2
	$(UNPACK)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

$(PREFIX)/bin/ffmpeg.exe: $(filter ffmpeg%,$(PKGS)) $(TARGETS) 
	cd $< && $(HOSTVARS) ./configure $(FFMPEGCONF)
	cd $< && $(MAKE) 
	mv $</ffmpeg.exe $(PREFIX)/bin

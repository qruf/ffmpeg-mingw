# sdl

SDL_VERSION := 1.2.15
SDL_URL := http://www.libsdl.org/release/SDL-$(SDL_VERSION).tar.gz

# FIXME check these
SDLCONF := $(HOSTCONF) \
	--enable-audio \
	--enable-video \
	--enable-events \
	--enable-directx \
	--enable-assembly \
	--disable-joystick \
	--disable-cdrom \
	--disable-threads \
	--disable-timers \
	--disable-file \
	--disable-video-x11 \
	--disable-video-aalib \
	--disable-video-dga \
	--disable-video-fbcon \
	--disable-video-directfb \
	--disable-video-ggi \
	--disable-video-svga \
	--disable-sdl-dlopen \
	$(SDLOPTS)

ifndef HAVE_MINGW_W64
SDLDEPS := .directx
endif

$(TARBALLS)/sdl-$(SDL_VERSION).tar.gz:
	$(call download,$(SDL_URL))

sdl: sdl-$(SDL_VERSION).tar.gz 
	$(UNPACK)
	$(APPLY) $(SRC)/sdl/direct_palette_ref.diff
	$(MOVE)

.sdl: sdl $(SDLDEPS)
	cd $< && $(HOSTVARS) ./configure $(SDLCONF)
	cd $< && $(MAKE) install
	touch $@

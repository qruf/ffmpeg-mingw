# cross-compile triplet
HOST := x86_64-w64-mingw32

# list of packages to enable; `make list` for a full list
PKGS_ENABLE := ffmpeg-git bzlib fontconfig frei0r gmp gnutls iconv libass libbluray libdcadec \
	libfdk-aac libfreetype libfribidi libgme-git libgsm libmfx libmodplug libmp3lame libopus librtmp \
	libschroedinger libspeex libtheora libvorbis libvpx libwebp libx264 libx265 libxvid libzimg-git \
	lzma sdl zlib

# example package-specific options
#
# FFMPEGOPTS := --enable-avisynth --enable-dxva2 --disable-ffprobe
# VPXOPTS    := --enable-vp9-highbitdepth
# X264OPTS   := --bit-depth=10
# X265OPTS   := -DHIGH_BIT_DEPTH=ON

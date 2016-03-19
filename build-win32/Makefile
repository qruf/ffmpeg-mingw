# Main makefile for VLC 3rd party libraries ("contrib")
# Copyright (C) 2003-2011 the VideoLAN team
#
# This file is under the same license as the vlc package.

include config.mak

TOPSRC ?= ..
TOPDST ?= ..
SRC := $(TOPSRC)/src
TARBALLS := $(TOPSRC)/tarballs

PKGS_RLS := $(patsubst $(SRC)/%/rules.mak,%,$(wildcard $(SRC)/*/rules.mak))
PKGS_GIT := $(shell egrep -ho ^[a-z0-9-]*-git $(SRC)/*/rules.mak)
PKGS_ALL := $(sort $(PKGS_RLS) $(PKGS_GIT) ffmpeg ffmpeg-git)
DATE := $(shell date +%Y%m%d)
VPATH := $(TARBALLS)

# Common download locations

GNU := http://ftp.gnu.org/gnu
SF := http://heanet.dl.sourceforge.net/sourceforge
VIDEOLAN := http://downloads.videolan.org/pub/videolan
CONTRIB_VIDEOLAN := http://downloads.videolan.org/pub/contrib/

# Machine-dependent variables

PREFIX ?= $(TOPDST)/$(HOST)
PREFIX := $(abspath $(PREFIX))
ARCH := $(shell $(SRC)/get-arch.sh $(HOST))
BUILD := $(shell cc -dumpmachine)
ifeq ($(ARCH),x86_64)
HAVE_WIN64 := 1
endif

ifneq ($(findstring $(origin CC),undefined default),)
CC := $(HOST)-gcc
endif
ifneq ($(findstring $(origin CXX),undefined default),)
CXX := $(HOST)-g++
endif
ifneq ($(findstring $(origin LD),undefined default),)
LD := $(HOST)-ld
endif
ifneq ($(findstring $(origin AR),undefined default),)
AR := $(HOST)-ar
endif
ifneq ($(findstring $(origin RANLIB),undefined default),)
RANLIB := $(HOST)-ranlib
endif
ifneq ($(findstring $(origin STRIP),undefined default),)
STRIP := $(HOST)-strip
endif
ifneq ($(findstring $(origin WIDL),undefined default),)
WIDL := $(HOST)-widl
endif
ifneq ($(shell $(CC) $(CFLAGS) -E -dM -include _mingw.h - < /dev/null | grep -E __MINGW64_VERSION_MAJOR),)
HAVE_MINGW_W64 := 1
endif

CCAS=$(CC) -c
cppcheck = $(shell $(CC) $(CFLAGS) -E -dM - < /dev/null | grep -E $(1))

EXTRA_CFLAGS += -I$(PREFIX)/include
CPPFLAGS := $(CPPFLAGS) $(EXTRA_CFLAGS)
CFLAGS := $(CFLAGS) $(EXTRA_CFLAGS)
CXXFLAGS := $(CXXFLAGS) $(EXTRA_CFLAGS) $(EXTRA_CXXFLAGS)
EXTRA_LDFLAGS += -L$(PREFIX)/lib
LDFLAGS := $(LDFLAGS) $(EXTRA_LDFLAGS)

ifdef DEBUG
CFLAGS := $(CFLAGS) -O0 -g
CXXFLAGS := $(CXXFLAGS) -O0 -g
endif

ACLOCAL_AMFLAGS += -I$(PREFIX)/share/aclocal
export ACLOCAL_AMFLAGS

# Tools

PKG_CONFIG ?= pkg-config
PKG_CONFIG_PATH := $(PREFIX)/lib/pkgconfig
export PKG_CONFIG_PATH

ifeq ($(shell curl --version >/dev/null 2>&1 || echo FAIL),)
download = curl -f -L -- "$(1)" > "$@"
else ifeq ($(shell wget --version >/dev/null 2>&1 || echo FAIL),)
download = rm -f $@.tmp && \
	wget --passive -c -p -O $@.tmp "$(1)" && \
	touch $@.tmp && \
	mv $@.tmp $@
else ifeq ($(which fetch >/dev/null 2>&1 || echo FAIL),)
download = rm -f $@.tmp && \
	fetch -p -o $@.tmp "$(1)" && \
	touch $@.tmp && \
	mv $@.tmp $@
else
download = $(error curl/wget/fetch not found!)
endif

# Common helpers

HOSTCONF := \
	--prefix="$(PREFIX)" \
	--datarootdir="$(PREFIX)/share" \
	--includedir="$(PREFIX)/include" \
	--libdir="$(PREFIX)/lib" \
	--build="$(BUILD)" --host="$(HOST)" --target="$(HOST)" \
	--program-prefix="" \
	--enable-static --disable-shared --disable-dependency-tracking \
	--without-pic

HOSTTOOLS := \
	CC="$(CC)" CXX="$(CXX)" LD="$(LD)" \
	AR="$(AR)" CCAS="$(CCAS)" RANLIB="$(RANLIB)" STRIP="$(STRIP)" \
	PATH="$(PREFIX)/bin:$(PATH)" PREFIX="$(PREFIX)"

HOSTVARS := $(HOSTTOOLS) \
	CPPFLAGS="$(CPPFLAGS)" CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)"

UNPACK_DIR = $@_tmp
UNPACK = $(RM) -R $@ $(UNPACK_DIR) && mkdir $(UNPACK_DIR) && \
		 tar -C $(UNPACK_DIR) --strip-components 1 -xvf $^ 
APPLY = (cd $(UNPACK_DIR) && patch -fp1) <
MOVE = mv $(UNPACK_DIR) $@ && touch $@
pkg_static = (cd $(UNPACK_DIR) && ../../src/pkg-static.sh $(1))

AUTOMAKE_DATA_DIRS=$(foreach n,$(foreach n,$(subst :, ,$(shell echo $$PATH)),$(abspath $(n)/../share)),$(wildcard $(n)/automake*))
UPDATE_AUTOCONFIG = for dir in $(AUTOMAKE_DATA_DIRS); do \
		if test -f "$${dir}/config.sub" -a -f "$${dir}/config.guess"; then \
			cp "$${dir}/config.sub" "$${dir}/config.guess" $(UNPACK_DIR); \
			break; \
		fi; \
	done

AUTOGEN = cd $@ && ./autogen.sh
AUTORECONF = autoreconf
RECONF = mkdir -p -- $(PREFIX)/share/aclocal && cd $< && $(AUTORECONF) -fiv $(ACLOCAL_AMFLAGS)
CMAKE = cmake . -DCMAKE_TOOLCHAIN_FILE=$(abspath toolchain.cmake) -DCMAKE_INSTALL_PREFIX=$(PREFIX)

all: install

PKGS := $(filter $(PKGS_ENABLE),$(PKGS_ALL))

include $(SRC)/*/rules.mak

PKGS_ALL := $(filter-out $(DEPSONLY),$(PKGS_ALL))
PKGS := $(filter $(PKGS_ENABLE),$(PKGS_ALL))
TARGETS := $(filter-out .ffmpeg, $(patsubst %,.%,$(PKGS:%-git=%)))

include $(SRC)/ffmpeg.mak

# Targets

.PHONY: all install clean distclean list

install: $(PREFIX)/bin/ffmpeg.exe

clean:
	-$(RM) $(PKGS:%=.%)
	-$(RM) toolchain.cmake
	-$(RM) -R */

distclean: clean
	-$(RM) -R "$(PREFIX)"
	-$(RM) $(TARBALLS)/*.*

list:
	@echo All packages:
	@echo '  $(PKGS_ALL)' | tr " " "\n" | sort | tr "\n" " " |fmt
	@echo Manually selected packages:
	@echo '  $(PKGS)' | tr " " "\n" | sort | tr "\n" " " |fmt

toolchain.cmake:
	$(RM) $@
	echo "set(CMAKE_SYSTEM_NAME Windows)" >> $@
	echo "set(CMAKE_RC_COMPILER $(HOST)-windres)" >> $@
	echo "set(_CMAKE_TOOLCHAIN_PREFIX $(HOST)-)" >> $@
	echo "set(CMAKE_C_COMPILER $(CC))" >> $@
	echo "set(CMAKE_CXX_COMPILER $(CXX))" >> $@
	echo "set(CMAKE_FIND_ROOT_PATH $(PREFIX))" >> $@
	echo "set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)" >> $@
	echo "set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)" >> $@
	echo "set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)" >> $@

.DELETE_ON_ERROR:

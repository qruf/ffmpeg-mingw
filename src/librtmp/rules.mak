# librtmp

RTMP_BRANCH := master
RTMP_GITURL := http://repo.or.cz/rtmpdump.git/snapshot/$(RTMP_BRANCH).tar.gz

$(TARBALLS)/librtmp-git.tar.gz:
	$(call download,$(RTMP_GITURL))

RTMPVARS=CROSS_COMPILE=$(HOST)- \
	PREFIX=$(PREFIX) \
	XCFLAGS=`pkg-config --cflags gnutls`

librtmp: librtmp-git.tar.gz 
	$(UNPACK)
	$(APPLY) $(SRC)/librtmp/librtmp-makefile.patch
	$(MOVE)

librtmp-git: librtmp

.librtmp: $(filter librtmp%,$(PKGS)) .gnutls .zlib
	cd $</librtmp && $(RTMPVARS) make install_base
	touch $@

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="scan-m3u"
PKG_VERSION="latest"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alexelec.in.ua"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain jq"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="scan-m3u: scan IPTV channels for TTV"
PKG_LONGDESC="scan-m3u: scan IPTV channels for TTV."
PKG_TOOLCHAIN="manual"

pre_make_target(){
  cp $ROOT/private/$PKG_NAME/ttv-logo.src $PKG_BUILD 2>/dev/null || true
  cp $ROOT/private/$PKG_NAME/ttv-xmltv.src $PKG_BUILD 2>/dev/null || true
}

make_target() {
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttvget-live.src
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttvget-direct.src
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttvstream.src
  [ -f ttv-logo.src ] && CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttv-logo.src || true
  [ -f ttv-xmltv.src ] && CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttv-xmltv.src || true
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp ttvget-live.src.x $INSTALL/usr/bin/ttvget-live
    cp ttvget-direct.src.x $INSTALL/usr/bin/ttvget-direct
    cp ttvstream.src.x $INSTALL/usr/bin/ttvstream
      ln -sf ttvstream $INSTALL/usr/bin/ttvstream-direct
    cp ttv-logo.src.x $INSTALL/usr/bin/ttv-logo 2>/dev/null || true
    cp ttv-xmltv.src.x $INSTALL/usr/bin/ttv-xmltv 2>/dev/null || true
  mkdir -p $INSTALL/usr/config/acestream
    cp $PKG_DIR/config/* $INSTALL/usr/config/acestream
}

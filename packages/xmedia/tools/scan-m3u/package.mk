################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

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
}

make_target() {
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttvget-live.src
  CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttvget-direct.src
  [ -f ttv-logo.src ] && CC=$CC CFLAGS=$CFLAGS ./shc -v -r -B -f ttv-logo.src || true
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp ttvget-live.src.x $INSTALL/usr/bin/ttvget-live
    cp ttvget-direct.src.x $INSTALL/usr/bin/ttvget-direct
    cp ttv-logo.src.x $INSTALL/usr/bin/ttv-logo 2>/dev/null || true
  mkdir -p $INSTALL/usr/config/acestream
    cp $PKG_DIR/config/* $INSTALL/usr/config/acestream
}

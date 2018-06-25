################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="transmission"
PKG_VERSION="2.94"
PKG_SHA256="35442cc849f91f8df982c3d0d479d650c6ca19310a994eccdaa79a4af3916b7d"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.transmissionbt.com/"
PKG_URL="https://github.com/transmission/transmission-releases/raw/master/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib openssl curl libevent"
PKG_SECTION="xmedia/torrent"
PKG_SHORTDESC="transmission: a fast, easy and free BitTorrent client"
PKG_LONGDESC="transmission is a fast, easy and free BitTorrent client."
PKG_TOOLCHAIN="cmake-make"

PKG_CONFIGURE_OPTS_TARGET="--enable-utp \
            --enable-largefile \
            --disable-nls \
            --disable-cli \
            --disable-mac \
            --enable-lightweight \
            --enable-daemon \
            --with-gnu-ld"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share/transmission/web/LICENSE
}

post_install() {
  enable_service transmission.service
}

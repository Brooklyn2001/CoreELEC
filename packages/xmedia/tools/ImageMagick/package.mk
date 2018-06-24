################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="ImageMagick"
PKG_VERSION="7.0.7-39"
PKG_SHA256="e7c1b19923bb97ed456c78b63b3259b809ebc8e3967c6d086450370c67eedf06"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.imagemagick.org"
PKG_URL="https://github.com/ImageMagick/ImageMagick/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="image manipulation library"
PKG_LONGDESC="ImageMagick is a software suite to create, edit, and compose bitmap images. It can read, convert and write images in a variety of formats (over 100)."

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --enable-shared \
                           --with-quantum-depth=8 \
                           --enable-hdri=no \
                           --disable-openmp"

makeinstall_target() {
  make install DESTDIR=$INSTALL
}

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/share/fonts/liberation
    cp -PR $PKG_DIR/config/truetype/* $INSTALL/usr/share/fonts/liberation
}

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="torrserver"
PKG_VERSION="latest"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/YouROK/TorrServer"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/torrent"
PKG_SHORTDESC="TorrServer, torrent to http."
PKG_LONGDESC="TorrServer, torrent to http."
PKG_TOOLCHAIN="manual"

make_target() {
  : # nothing to make here
}

makeinstall_target() {
  mkdir -p $INSTALL
    cp -PR ./* $INSTALL
}

post_install() {
  enable_service torrserver.service
}

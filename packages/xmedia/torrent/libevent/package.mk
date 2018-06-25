################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="libevent"
PKG_VERSION="2.1.8-stable"
PKG_SHA256="965cc5a8bb46ce4199a47e9b2c9e1cae3b137e8356ffdad6d94d3b9069b71dc2"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://libevent.org/"
PKG_URL="https://github.com/libevent/libevent/releases/download/release-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl zlib"
PKG_SECTION="xmedia/torrent"
PKG_SHORTDESC="libevent: A library for asynchronous event notification"
PKG_LONGDESC="The libevent API provides a mechanism to execute a callback function when a specific event occurs on a file descriptor or after a timeout has been reached. It is meant to replace the asynchronous event loop found in event-driven network servers."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static --enable-openssl"

post_makeinstall_target() {
  rm -r $INSTALL
}

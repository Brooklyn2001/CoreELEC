# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="ipset"
PKG_VERSION="7.0"
PKG_SHA256="c6fa0f3b7d514e3edd0113ea02f82ab299e5467a4b7733dc31e127cdccc741af"
PKG_LICENSE="GPL2"
PKG_SITE="http://ipset.netfilter.org/"
PKG_URL="$PKG_SITE/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain linux libmnl"
PKG_LONGDESC="Administration tool for IP sets."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr --sbindir=/usr/bin --with-kmod=no --with-kbuild=$(kernel_path)"

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="pcsc-lite"
PKG_VERSION="1.8.23"
PKG_SHA256="5a27262586eff39cfd5c19aadc8891dd71c0818d3d629539bd631b958be689c9"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://pcsclite.apdu.fr"
PKG_URL="https://pcsclite.apdu.fr/files/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_SECTION="xmedia/tvservice"
PKG_LONGDESC="Middleware to access a smart card using SCard API (PC/SC)"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared \
            --disable-static \
            --disable-libudev \
            --enable-libusb \
            --enable-usbdropdir=/usr/lib/pcsc/drivers"

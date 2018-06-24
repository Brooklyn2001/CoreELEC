################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="pcsc-lite"
PKG_VERSION="1.8.22"
PKG_SHA256="6a358f61ed3b66a7f6e1f4e794a94c7be4c81b7a58ec360c33791e8d7d9bd405"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://pcsclite.alioth.debian.org/pcsclite.html"
PKG_URL="https://alioth.debian.org/frs/download.php/file/4225/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="Middleware to access a smart card using SCard API (PC/SC)"
PKG_LONGDESC="Middleware to access a smart card using SCard API (PC/SC)"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared \
            --disable-static \
            --disable-libudev \
            --enable-libusb \
            --enable-usbdropdir=/usr/lib/pcsc/drivers"

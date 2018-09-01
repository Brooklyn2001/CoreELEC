# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="oscam"
PKG_VERSION_NUMBER="11431"
PKG_VERSION="5749643"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.streamboard.tv/oscam/wiki"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain pcsc-lite openssl"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="oscam: OSCam is Open Source Conditional Access Modul."
PKG_LONGDESC="OSCam is Open Source Conditional Access Modul."

unpack() {
  git clone http://repo.or.cz/oscam.git $PKG_BUILD
  cd $PKG_BUILD
  git reset --hard $PKG_VERSION
  cd $ROOT
}

pre_configure_target() {
  export OSCAM_VERSION_NUMBER="$PKG_VERSION_NUMBER"
  cp -f $PKG_DIR/config/SoftCam.Key $PKG_BUILD
}

PKG_CMAKE_OPTS_TARGET="-DLIBUSBDIR=$SYSROOT_PREFIX/usr \
                       -DCMAKE_INSTALL_PREFIX=/usr \
                       -DWITH_SSL=1 \
                       -DHAVE_LIBCRYPTO=1 \
                       -DHAVE_DVBAPI=1 \
                       -DWITH_STAPI=0 \
                       -DWEBIF=1 \
                       -DWITH_EMU=1 \
                       -DWITH_DEBUG=0 \
                       -DOPTIONAL_INCLUDE_DIR=$SYSROOT_PREFIX/usr/include \
                       -DSTATIC_LIBUSB=1 \
                       -DCLOCKFIX=0 \
                       -DCARDREADER_DB2COM=OFF"

makeinstall_target() {
  mkdir -p  $INSTALL/usr/config/oscam
    cp -a $PKG_DIR/bin $INSTALL/usr/config/oscam
    cp -a $PKG_DIR/config $INSTALL/usr/config/oscam
    rm -f $INSTALL/usr/config/oscam/config/SoftCam.Key

  mkdir -p  $INSTALL/usr/bin
    cp $PKG_BUILD/.$TARGET_NAME/oscam $INSTALL/usr/bin
    cp $PKG_BUILD/.$TARGET_NAME/utils/list_smargo $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
}

post_install() {
  enable_service oscam.service
}

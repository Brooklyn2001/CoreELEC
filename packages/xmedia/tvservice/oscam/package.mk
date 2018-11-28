# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2011-present Alex@ELEC (http://alexelec.in.ua)

PKG_NAME="oscam"
PKG_VERSION="3e250cf"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.streamboard.tv/oscam/wiki"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain pcsc-lite openssl"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="oscam: OSCam is Open Source Conditional Access Modul."
PKG_LONGDESC="OSCam is Open Source Conditional Access Modul."

#colors
  RED="\033[0;31m"
  YELLOW="\033[1;33m"
  ENDCOLOR="\033[0m"

unpack() {
  git clone https://github.com/knicko007/oscam-smod.git $PKG_BUILD
  cd $PKG_BUILD
  git reset --hard $PKG_VERSION
  OSCAM_REVISION=`cat .trunk-svn`
  echo "-----------------------------------------------------------"
  echo -e $RED"****** Oscam revision:"$ENDCOLOR $YELLOW"$OSCAM_REVISION"$ENDCOLOR $RED"******"$ENDCOLOR
  echo "-----------------------------------------------------------"
  cd $ROOT
}

PKG_CMAKE_OPTS_TARGET="-DLIBUSBDIR=$SYSROOT_PREFIX/usr \
                       -DCMAKE_INSTALL_PREFIX=/usr \
                       -DWITH_SSL=0 \
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

  mkdir -p  $INSTALL/usr/bin
    cp $PKG_BUILD/.$TARGET_NAME/oscam $INSTALL/usr/bin
    cp $PKG_BUILD/.$TARGET_NAME/utils/list_smargo $INSTALL/usr/bin
    cp $PKG_DIR/scripts/* $INSTALL/usr/bin
}

post_install() {
  enable_service oscam.service
}

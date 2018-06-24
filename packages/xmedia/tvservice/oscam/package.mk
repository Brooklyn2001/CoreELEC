################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.ru
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.ru)
################################################################################

PKG_NAME="oscam"
PKG_VERSION="941f2e8"
PKG_VERSION_NUMBER="11425"
PKG_SHA256="a3b154def4acf2ab7f09d1bf1c96109ef412a25b721efcd327ba05e2af978dc9"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.streamboard.tv/oscam/wiki"
PKG_URL="http://repo.or.cz/oscam.git/snapshot/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain pcsc-lite"
PKG_SECTION="xmedia/tvservice"
PKG_SHORTDESC="oscam: OSCam is Open Source Conditional Access Modul."
PKG_LONGDESC="OSCam is Open Source Conditional Access Modul."

pre_configure_target() {
  export OSCAM_VERSION_NUMBER="$PKG_VERSION_NUMBER"
  cp -f $PKG_DIR/config/SoftCam.Key $PKG_BUILD
}

PKG_CMAKE_OPTS_TARGET="-DLIBUSBDIR=$SYSROOT_PREFIX/usr \
                       -DCMAKE_INSTALL_PREFIX=/usr \
                       -DWITH_SSL=0 \
                       -DHAVE_LIBCRYPTO=0 \
                       -DHAVE_DVBAPI=1 \
                       -DWITH_STAPI=0 \
                       -DWEBIF=1 \
                       -DWITH_EMU=1 \
                       -DWITH_DEBUG=0 \
                       -DOPTIONAL_INCLUDE_DIR=$SYSROOT_PREFIX/usr/include \
                       -DSTATIC_LIBUSB=1 \
                       -DCLOCKFIX=0"

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

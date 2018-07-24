################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="mediacenter"
PKG_VERSION=""
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://alexelec.in.ua"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain $MEDIACENTER"
PKG_SECTION="virtual"
PKG_SHORTDESC="Mediacenter: Metapackage"
PKG_LONGDESC="Mediacenter: Metapackage"

# kodi skins
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $MEDIACENTER-theme-$SKIN_DEFAULT"

  for i in $SKINS; do
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $MEDIACENTER-theme-$i"
  done

# some python stuff needed for various addons
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET Pillow \
                                          simplejson \
                                          pycryptodome"

# settings addon
  if [ -n "$DISTRO_PKG_SETTINGS" ]; then
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $DISTRO_PKG_SETTINGS"
  fi

# other packages
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET xmlstarlet"

  if [ "$JOYSTICK_SUPPORT" = "yes" ]; then
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET peripheral.joystick"
  fi

# kodi-binary-addons pvr
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pvr.iptvsimple"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pvr.hts"

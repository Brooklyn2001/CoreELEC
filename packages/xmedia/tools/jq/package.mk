################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="jq"
PKG_VERSION="1.5"
PKG_SHA256="c4d2bfec6436341113419debf479d833692cc5cdab7eb0326b5a4d4fbe9f493c"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://stedolan.github.io/jq/"
PKG_URL="https://github.com/stedolan/jq/releases/download/$PKG_NAME-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="xmedia/tools"
PKG_SHORTDESC="Command-line JSON processor"
PKG_LONGDESC="jq is like sed for JSON data – you can use it to slice and filter and map and transform structured data with the same ease that sed, awk, grep and friends let you play with text."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \ 
                           --enable-static \
                           --disable-maintainer-mode"

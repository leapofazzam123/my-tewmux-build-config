TERMUX_PKG_HOMEPAGE=https://launchpad.net/libdbusmenu-qt
TERMUX_PKG_DESCRIPTION="dbusmenu library for Qt"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
TERMUX_PKG_VERSION="0.9.3+16.04.20160218-0ubuntu1"
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL="https://github.com/unity8-team/libdbusmenu-qt/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256=bc2c3960c0c6b520e42e652b6a71b769cff6cb651adece92d2a0bc6bdff37c29
TERMUX_PKG_DEPENDS="qt5-qtbase"
TERMUX_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DUSE_QT4=OFF -DUSE_QT5=ON -DWITH_DOC=OFF"

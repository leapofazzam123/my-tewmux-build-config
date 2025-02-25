TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_VERSION=4.31
TERMUX_PKG_SRCURL=https://archive.mozilla.org/pub/nspr/releases/v$TERMUX_PKG_VERSION/src/nspr-$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=5729da87d5fbf1584b72840751e0c6f329b5d541850cacd1b61652c95015abc8
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_HOST_PLATFORM=$TERMUX_ARCH-linux-gnu

termux_step_post_get_source() {
	cp -r $TERMUX_PKG_SRCDIR/nspr/* $TERMUX_PKG_SRCDIR
}

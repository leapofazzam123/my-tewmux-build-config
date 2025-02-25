TERMUX_PKG_HOMEPAGE=https://wayland.freedesktop.org/
TERMUX_PKG_DESCRIPTION="Wayland protocol library"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="Leonid Pliushch <leonid.pliushch@gmail.com>"
TERMUX_PKG_VERSION=1.19.0
TERMUX_PKG_SRCURL=https://wayland.freedesktop.org/releases/wayland-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=baccd902300d354581cd5ad3cc49daa4921d55fb416a5883e218750fef166d15
TERMUX_PKG_DEPENDS="libandroid-support, libffi, libxml2, libexpat"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-documentation --with-host-scanner"

termux_step_pre_configure() {
	autoreconf -fi
}

termux_step_post_make_install() {
	sed -i 's/wayland_scanner=${exec_prefix}\/bin\/wayland-scanner/wayland_scanner=\/usr\/bin\/wayland-scanner/g' /data/data/com.termux/files/usr/lib/pkgconfig/wayland-scanner.pc
}

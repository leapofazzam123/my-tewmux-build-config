TERMUX_SUBPKG_DESCRIPTION="A generic and open source machine emulator and virtualizer"
TERMUX_SUBPKG_DEPENDS="attr, glib, libbz2, libc++, libcap-ng, libcurl, libgcrypt, libiconv, libjpeg-turbo, liblzo, libnfs, libpixman, libpng, libssh, libx11, ncurses, qemu-common, resolv-conf, sdl2, sdl2-image, zlib"
TERMUX_SUBPKG_CONFLICTS="qemu-system-mips-headless"
TERMUX_SUBPKG_DEPEND_ON_PARENT=no

TERMUX_SUBPKG_INCLUDE="
bin/qemu-system-mips
share/man/man1/qemu-system-mips.1.gz
bin/qemu-mips
"


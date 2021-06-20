TERMUX_PKG_HOMEPAGE=https://www.qemu.org
TERMUX_PKG_DESCRIPTION="A generic and open source machine emulator and virtualizer"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="Leonid Pliushch <leonid.pliushch@gmail.com>"
TERMUX_PKG_VERSION=1:5.2.0
TERMUX_PKG_REVISION=5
TERMUX_PKG_SRCURL=https://github.com/ktemkin/qemu
TERMUX_PKG_BRANCH='with_tcti'
TERMUX_PKG_SHA256="cc43cb351bead1332911936f511b4eaa203119ba5ab1622e6cc786640686771e"
TERMUX_PKG_DEPENDS="attr, glib, libbz2, libc++, libcap-ng, libcurl, libgcrypt, libiconv, libjpeg-turbo, liblzo, libnfs, libpixman, libpng, libssh, libx11, ncurses, qemu-common, resolv-conf, sdl2, sdl2-image, zlib, gtk3, libvte, spice-server"
TERMUX_PKG_CONFLICTS="qemu-system-x86_64, qemu-system-x86_64-headless, qemu-system-x86-64-headless"
TERMUX_PKG_REPLACES="qemu-system-x86_64, qemu-system-x86_64-headless, qemu-system-x86-64-headless"
TERMUX_PKG_PROVIDES="qemu-system-x86_64"
TERMUX_PKG_BUILD_IN_SRC=true

# Remove files already present in qemu-utils and qemu-common.
TERMUX_PKG_RM_AFTER_INSTALL="
bin/elf2dmp
bin/qemu-edid
bin/qemu-img
bin/qemu-io
bin/qemu-nbd
bin/qemu-pr-helper
bin/qemu-storage-daemon
libexec/virtfs-proxy-helper
libexec/qemu-bridge-helper
share/applications
share/icons
share/doc
share/man/man1/qemu.1*
share/man/man1/qemu-img.1*
share/man/man1/virtfs-proxy-helper.1*
share/man/man7
share/man/man8/qemu-ga.8*
share/man/man8/qemu-nbd.8*
share/man/man8/qemu-pr-helper.8*
share/qemu
"

termux_step_configure() {
	termux_setup_ninja

	if [ "$TERMUX_ARCH" = "i686" ]; then
		LDFLAGS+=" -latomic"
	fi

	local QEMU_TARGETS=""

	# System emulation.
	QEMU_TARGETS+="aarch64-softmmu,"
	QEMU_TARGETS+="arm-softmmu,"
	QEMU_TARGETS+="i386-softmmu,"
	QEMU_TARGETS+="riscv32-softmmu,"
	QEMU_TARGETS+="riscv64-softmmu,"
	QEMU_TARGETS+="x86_64-softmmu"
	QEMU_TARGETS+="ppc-softmmu"
	QEMU_TARGETS+="ppc64-softmmu"
	QEMU_TARGETS+="mips-softmmu"
	QEMU_TARGETS+="mips64-softmmu"
	QEMU_TARGETS+="sparc-softmmu"
	QEMU_TARGETS+="sparc64-softmmu"
	QEMU_TARGETS+="m68k-softmmu"
	CXXFLAGS+="-I$TERMUX_PKG_TMPDIR/include/spice-server -I$TERMUX_PKG_TMPDIR/include/spice-1"
	CFLAGS+=" $CPPFLAGS"
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -landroid-shmem -llog"

	cp "$TERMUX_PREFIX"/bin/libgcrypt-config \
		"$TERMUX_PKG_TMPDIR"/libgcrypt-config
		export PATH="$PATH:$TERMUX_PKG_TMPDIR"
	cp -r "$TERMUX_PREFIX"/include/spice-server \
                "$TERMUX_PKG_TMPDIR"/include

	cp -r "$TERMUX_PREFIX"/include/spice-1 \
                "$TERMUX_PKG_TMPDIR"/include

	# Note: using --disable-stack-protector since stack protector
	# flags already passed by build scripts but we do not want to
	# override them with what QEMU configure provides.
	./configure \
		--prefix="$TERMUX_PREFIX" \
		--cross-prefix="${TERMUX_HOST_PLATFORM}-" \
		--host-cc="gcc" \
		--cc="$CC" \
		--cxx="$CXX" \
		--objcc="$CC" \
		--disable-stack-protector \
		--smbd="$TERMUX_PREFIX/bin/smbd" \
		--enable-coroutine-pool \
		--audio-drv-list=sdl \
		--enable-trace-backends=nop \
		--disable-guest-agent \
		--disable-gnutls \
		--disable-nettle \
		--enable-gcrypt \
		--enable-sdl \
		--enable-sdl-image \
		--enable-gtk \
		--enable-vte \
		--enable-curses \
		--enable-iconv \
		--enable-vnc \
		--disable-vnc-sasl \
		--enable-vnc-jpeg \
		--enable-vnc-png \
		--disable-xen \
		--disable-xen-pci-passthrough \
		--enable-virtfs \
		--enable-curl \
		--enable-fdt \
		--disable-kvm \
		--disable-hax \
		--disable-hvf \
		--disable-whpx \
		--enable-libnfs \
		--disable-libusb \
		--disable-lzo \
		--disable-snappy \
		--enable-bzip2 \
		--disable-lzfse \
		--enable-spice \
		--disable-seccomp \
		--enable-libssh \
		--enable-libxml2 \
		--enable-bochs \
		--enable-cloop \
		--enable-dmg \
		--enable-parallels \
		--enable-qed \
		--enable-sheepdog \
		--target-list="$QEMU_TARGETS"
}

termux_step_post_make_install() {
	local i
	for i in aarch64 arm i386 riscv32 riscv64 x86_64; do
		ln -sfr \
			"${TERMUX_PREFIX}"/share/man/man1/qemu.1 \
			"${TERMUX_PREFIX}"/share/man/man1/qemu-system-${i}.1
	done
}

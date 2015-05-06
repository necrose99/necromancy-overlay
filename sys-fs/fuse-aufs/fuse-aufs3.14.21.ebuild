# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuseiso/fuseiso-20070708-r1.ebuild,v 1.3 2014/01/14 13:58:42 ago Exp $
# https://github.com/Sabayon-Labs/spike-community-overlay some alpha/beta ebuilds live hear 
# layman -f -a https://raw.githubusercontent.com/Sabayon-Labs/spike-community-overlay/master/overlays.xml
# Spike-pentesting.org a Gentoo & Sabayon Based Pentest Distribution. 
# necrose99 Michael R. Lawence
## Wishlist:no eligant means to if sabayon-kernel or virtual-(IE gentoo) 
#or our preffered spike kerenl (sabayon/gentoo var) slighly hardened & Pentesty var of sabayon defacto kernel
## Else gentoo's or etc. 
#pitty thier isnt an eassier automagical kernel probe/kernel-SRC's probe and make We all have diff kernel flavor tastes.
# but perl/APP:Witchcraft CI-tinderbox will chew & make bin-packages in ourcase
# USE="+recursion"  for /usr/src/$LINUX-{$wildcard}-{$wildversion} 
#nvidia patch day urhgrr wish for that too +recursion"
# find and try and build the fuse for them if aufs3 modules aint built when posible... .
# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

AT_M4DIR="config"
AUTOTOOLS_AUTORECONF="1"
AUTOTOOLS_IN_SOURCE_BUILD="1"

inherit bash-completion-r1 flag-o-matic linux-info linux-mod toolchain-funcs autotools-utils

if [ ${PV} == "9999" ] ; then
	inherit git-2
	MY_PV=9999
	EGIT_REPO_URI="https://github.com/sfjro/aufs4-standalone.git"
else
if [ ${PV} == "4" ] ; then
	inherit git-2
	MY_PV=4
	EGIT_REPO_URI="https://github.com/sfjro/aufs4-standalone.git"
fi
else
if [ ${PV} == "aufs3.14.21" ] ; then
	inherit git-2
	MY_PV=4
	EGIT_REPO_URI="git://git.code.sf.net/p/aufs/aufs3-standalone aufs-aufs3-standalone Tree [971fa9] aufs3.14.21+ /"
fi

SLOT="0"
IUSE="custom-cflags debug debug-log +rootfs"
RESTRICT="test"

DEPEND="dev-lang/perl
	virtual/awk
"

RDEPEND="${DEPEND}
	!sys-fs/zfs-fuse
	!sys-kernel/spl
"

pkg_setup() {
	linux-info_pkg_setup
	CONFIG_CHECK="!DEBUG_LOCK_ALLOC
		!GRKERNSEC_HIDESYM
		BLK_DEV_LOOP
		EFI_PARTITION
		IOSCHED_NOOP
		KALLSYMS
		MODULES
		!PAX_KERNEXEC_PLUGIN_METHOD_OR
		ZLIB_DEFLATE
		ZLIB_INFLATE
	"

	use rootfs && \
		CONFIG_CHECK="${CONFIG_CHECK} BLK_DEV_INITRD
			DEVTMPFS"

	kernel_is ge 2 6 26 || die "Linux 2.6.26 or newer required"

	[ ${PV} != "9999" ] && \
		{ kernel_is le 3 15 || die "Linux 3.15 is the latest supported version."; }

	check_extra_config
}

src_prepare() {
	# Remove GPLv2-licensed ZPIOS unless we are debugging
	use debug || sed -e 's/^subdir-m += zpios$//' -i "${ZFS_S}/module/Makefile.in"

	# Workaround for hard coded path
	sed -i "s|/sbin/lsmod|/bin/lsmod|" "${SPL_S}"/scripts/check.sh || die

	# splat is unnecessary unless we are debugging
	use debug || sed -e 's/^subdir-m += splat$//' -i "${SPL_S}/module/Makefile.in"

	local d
	for d in "${ZFS_S}" "${SPL_S}"; do
		pushd "${d}"
		S="${d}" BUILD_DIR="${d}" autotools-utils_src_prepare
		unset AUTOTOOLS_BUILD_DIR
		popd
	done
}

src_configure() {
	use custom-cflags || strip-flags
	filter-ldflags -Wl,*

	set_arch_to_kernel

	einfo "Configuring SPL..."
	local myeconfargs=(
		--bindir="${EPREFIX}/bin"
		--sbindir="${EPREFIX}/sbin"
		--with-config=all
		--with-linux="${KV_DIR}"
		--with-linux-obj="${KV_OUT_DIR}"
		$(use_enable debug)
		$(use_enable debug-log)
	)
	pushd "${SPL_S}"
	BUILD_DIR="${SPL_S}" ECONF_SOURCE="${SPL_S}" autotools-utils_src_configure
	unset AUTOTOOLS_BUILD_DIR
	popd

	einfo "Configuring ZFS..."
	local myeconfargs=(
		--bindir="${EPREFIX}/bin"
		--sbindir="${EPREFIX}/sbin"
		--with-config=kernel
		--with-linux="${KV_DIR}"
		--with-linux-obj="${KV_OUT_DIR}"
		--with-spl="${SPL_S}"
		$(use_enable debug)
	)
	pushd "${ZFS_S}"
	BUILD_DIR="${ZFS_S}" ECONF_SOURCE="${ZFS_S}" autotools-utils_src_configure
	unset AUTOTOOLS_BUILD_DIR
	popd
}

src_compile() {
	einfo "Compiling SPL..."
	pushd "${SPL_S}"
	BUILD_DIR="${SPL_S}" ECONF_SOURCE="${SPL_S}" autotools-utils_src_compile
	unset AUTOTOOLS_BUILD_DIR
	popd

	einfo "Compiling ZFS..."
	pushd "${ZFS_S}"
	BUILD_DIR="${ZFS_S}" ECONF_SOURCE="${ZFS_S}" autotools-utils_src_compile
	unset AUTOTOOLS_BUILD_DIR
	popd
}

src_install() {
	pushd "${SPL_S}"
	BUILD_DIR="${SPL_S}" ECONF_SOURCE="${SPL_S}" autotools-utils_src_install
	unset AUTOTOOLS_BUILD_DIR
	popd

	pushd "${ZFS_S}"
	BUILD_DIR="${ZFS_S}" ECONF_SOURCE="${ZFS_S}" autotools-utils_src_install
	unset AUTOTOOLS_BUILD_DIR
	dodoc "${ZFS_S}"/AUTHORS "${ZFS_S}"/COPYRIGHT "${ZFS_S}"/DISCLAIMER "${ZFS_S}"/README.markdown
	popd
}


EAPI=5
inherit eutils versionator

DESCRIPTION="virtual to build sys-fs/aufs3 as a FUSE module for simplicity & Ease."

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-debug doc +fuse hfs inotify kernel-patch +nfs pax_kernel +ramfs"

RDEPEND="sys-fs/aufs3 
  	sys-fs/fuse
	>=sys-kernel/spike-sources-0
	>=sys-kernel/linux-spike-0
	>=sabayon-sources-0
  	>=sys-kernel/linux-sabayon-0
	>=virtual/linux-kernel-0
	>=virtual/linux-sources-0"
DEPEND="${RDEPEND}
pkg_postinst() {
	linux-mod_pkg_postinst

	if use x86 || use arm
	then
		ewarn "32-bit kernels will likely require increasing vmalloc to"
		ewarn "at least 256M and decreasing zfs_arc_max to some value less than that."
	fi

	ewarn "This version of ZFSOnLinux includes support for features flags."
	ewarn "If you upgrade your pools to make use of feature flags, you will lose"
	ewarn "the ability to import them using older versions of ZFSOnLinux."
	ewarn "Any new pools will be created with feature flag support and will"
	ewarn "not be compatible with older versions of ZFSOnLinux. To create a new"
	ewarn "pool that is backward compatible, use zpool create -o version=28 ..."
}

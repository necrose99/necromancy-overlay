# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2:2.6"

inherit flag-o-matic eutils multilib python toolchain-funcs

XEN_EXTFILES_URL="http://xenbits.xensource.com/xen-extfiles"
LIBPCI_URL=ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci
GRUB_URL=mirror://gnu-alpha/grub
SRC_URI="
		http://bits.xensource.com/oss-xen/release/${PV}/xen-${PV}.tar.gz
		$GRUB_URL/grub-0.97.tar.gz
		$XEN_EXTFILES_URL/zlib-1.2.3.tar.gz
		$LIBPCI_URL/pciutils-2.2.9.tar.bz2
		$XEN_EXTFILES_URL/lwip-1.3.0.tar.gz
		$XEN_EXTFILES_URL/newlib/newlib-1.16.0.tar.gz"

S="${WORKDIR}/xen-${PV}"

DESCRIPTION="allows XEN HVM guests to be run in a stubdom which improves isolation and performance."
HOMEPAGE="http://xen.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="custom-cflags"

DEPEND="sys-devel/gettext"

RDEPEND=">=app-emulation/xen-4.2.1"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {

	# if the user *really* wants to use their own custom-cflags, let them
	if use custom-cflags; then
		einfo "User wants their own CFLAGS - removing defaults"
		# try and remove all the default custom-cflags
		find "${S}" -name Makefile -o -name Rules.mk -o -name Config.mk -exec sed \
			-e 's/CFLAGS\(.*\)=\(.*\)-O3\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-march=i686\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-fomit-frame-pointer\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-g3*\s\(.*\)/CFLAGS\1=\2 \3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-O2\(.*\)/CFLAGS\1=\2\3/' \
			-i {} \;
	fi

	#Substitute for internal downloading
	cp $DISTDIR/zlib-1.2.3.tar.gz \
		$DISTDIR/pciutils-2.2.9.tar.bz2 \
		$DISTDIR/lwip-1.3.0.tar.gz \
		$DISTDIR/newlib-1.16.0.tar.gz \
		$DISTDIR/grub-0.97.tar.gz \
		./stubdom/ || die "files not coped to stubdom"
	einfo "files copied to stubdom"

	# Patch the unmergeable newlib, fix most of the leftover gcc QA issues
	cp "${FILESDIR}"/newlib-implicits.patch stubdom || die

	# Patch stubdom/Makefile to patch insource newlib & prevent internal downloading
	epatch "${FILESDIR}"/${P/-stubdom/}-externals.patch

	# Drop .config and Fix gcc-4.6
	epatch 	"${FILESDIR}"/${PN/-stubdom/}-4-fix_dotconfig-gcc.patch

	# fix jobserver in Makefile
	epatch "${FILESDIR}"/${PN/-stubdom/}-4.2.0-jserver.patch

	#Sec patch
	epatch "${FILESDIR}"/${PN/-stubdom/}-4-CVE-2012-6075-XSA-41.patch

	# wrt Bug #455196
	epatch "${FILESDIR}"/${P/-stubdom/}-CC.patch
}

src_compile() {
	use custom-cflags || unset CFLAGS
	if test-flag-CC -fno-strict-overflow; then
		append-flags -fno-strict-overflow
	fi

	emake CC="$(tc-getCC)" LD="$(tc-getLD)" AR="$(tc-getAR)" -C tools/include

	if use x86; then
		emake CC="$(tc-getCC)" LD="$(tc-getLD)" AR="$(tc-getAR)" \
		XEN_TARGET_ARCH="x86_32" -C stubdom genpath ioemu-stubdom
	elif use amd64; then
		emake CC="$(tc-getCC)" LD="$(tc-getLD)" \
		XEN_TARGET_ARCH="x86_64" -C stubdom genpath ioemu-stubdom
	fi
}

src_install() {
	if use x86; then
		emake XEN_TARGET_ARCH="x86_32" DESTDIR="${D}" -C stubdom install-ioemu
	fi
	if use amd64; then
		emake XEN_TARGET_ARCH="x86_64" DESTDIR="${D}" -C stubdom install-ioemu
	fi
}

pkg_postinst() {
	elog " Official Xen Guide and the unoffical wiki page:"
	elog " http://www.gentoo.org/doc/en/xen-guide.xml"
	elog " http://en.gentoo-wiki.com/wiki/Xen/"
	elog " Xen stubdom information"
	elog " http://wiki.xen.org/wiki/Device_Model_Stub_Domains"
}

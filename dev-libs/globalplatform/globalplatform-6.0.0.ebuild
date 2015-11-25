# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ jdkbx

EAPI=4

WANT_AUTOMAKE="1.11"

inherit eutils libtool autotools

DESCRIPTION="This is a library for providing access to OpenPlatform 2.0.1' and 
GlobalPlatform 2.1.1 conforming smart cards."

HOMEPAGE="http://sourceforge.net/projects/globalplatform/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=sys-libs/zlib-1.2.3
	>=dev-libs/openssl-0.9.7e
	sys-apps/pcsc-lite"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/gcc-fix.patch

}

src_prepare() {
	cd "${S}"
	sed -i -e '/^LDFLAGS/d' configure.in
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS COPYING COPYING.LESSER NEWS README
}

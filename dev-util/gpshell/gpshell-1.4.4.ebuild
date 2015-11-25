# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ jdkbx

inherit eutils libtool autotools

DESCRIPTION="GPShell is a script interpreter which talks to a smart card. It can establish a secure channel with a smart card, load, instantiate, delete, list applets on a smart card."

HOMEPAGE="http://sourceforge.net/projects/globalplatform/"
SRC_URI="mirror://sourceforge/globalplatform/${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-libs/globalplatform-6.0.0
	>=sys-libs/zlib-1.2.3
	>=dev-libs/openssl-0.9.7e
	sys-apps/pcsc-lite"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog COPYING COPYING.LESSER NEWS README
}

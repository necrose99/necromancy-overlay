# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools-multilib

DESCRIPTION="Yubico Universal 2nd Factor (U2F) server C Library"
HOMEPAGE="https://developers.yubico.com/libu2f-server/"
SRC_URI="https://developers.yubico.com/${PN}/Releases/${P}.tar.xz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

RDEPEND="
	dev-libs/openssl
	dev-libs/hidapi
	dev-libs/json-c"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	autotools-multilib_src_prepare
}

src_configure() {
	autotools-multilib_src_configure
}

src_install() {
	autotools-multilib_src_install
}

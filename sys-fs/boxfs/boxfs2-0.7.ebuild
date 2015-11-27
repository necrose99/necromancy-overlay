# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit eutils

DESCRIPTION="A FUSE filesystem to access files on box.net accounts"
HOMEPAGE="https://github.com/drotiro/boxfs2"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-fs/fuse
	dev-libs/libxml2
	net-misc/curl
	dev-libs/libzip"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	dodir /usr/bin
	emake PREFIX="${D}usr" install

	dodoc README
}

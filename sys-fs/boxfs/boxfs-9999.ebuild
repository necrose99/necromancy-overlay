# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="git://github.com/drotiro/${PN}.git
	http://github.com/drotiro/${PN}.git"
inherit git-3 multilib

DESCRIPTION="A FUSE filesystem to access files on box.net accounts"
HOMEPAGE="https://github.com/drotiro/boxfs2"
SRC_URI=""
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-fs/fuse
	dev-libs/libxml2
	net-misc/curl
	dev-libs/libzip
	dev-libs\libapp"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

EGIT_CHECKOUT_DIR=${WORKDIR}/${P}
D=${WORKDIR}/${P}
src_unpack() {
git-r3_src_unpack
}
src_install() {
	dodir /usr/bin
	emake PREFIX="${D}usr" install

	dodoc README
}

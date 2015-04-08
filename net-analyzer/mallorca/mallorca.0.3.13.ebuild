# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-3

DESCRIPTION="mallory inspired nodejs Man-in-the-middle proxy for HTTPS with SSL verification and connection pooling/keep-alive."
HOMEPAGE="https://github.com/braintree/mallorca"
SRC_URI=""
EGIT_REPO_URI="https://github.com/braintree/mallorca.git"
EGIT_COMMIT="v${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/nodejs
	sys-apps/npm
	dev-vcs/git"
RDEPEND="${DEPEND}"

src_configure() {
	# nasty hack around the lack of DESTDIR not working. npm uses relative links
	# anyways so this should work.
	econf --prefix="${D}/usr"
}

src_install() {
	node cli.js install -g -f --unsafe-perm
}
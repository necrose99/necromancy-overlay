# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit linux-info systemd user

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/braintree/${PN}.git"
	inherit git-r3 autotools #git-2
	KEYWORDS="~*"
	LICENSE="MIT"
	SLOT="0"
else
	SRC_URI="https://github.com/braintree/mallorca/archive/${PN}/releases/v${PV}/${P}.tar.xz"
	# https://github.com/braintree/mallorca/archive/0.3.13.tar.gz ref.. may need pv hander ssawp.
	KEYWORDS="~*"
	LICENSE="MIT"
	SLOT="0"
	IUSE=""
fi

DESCRIPTION="mallory inspired nodejs Man-in-the-middle proxy for HTTPS with SSL verification and connection pooling/keep-alive."


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

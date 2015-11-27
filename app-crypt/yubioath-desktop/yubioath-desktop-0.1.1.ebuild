# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

SRC_URI="http://opensource.yubico.com/yubioath-desktop/releases/${P}.tar.gz"
HOMEPAGE="http://opensource.yubico.com/yubioath-desktop"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="BSD-2"

inherit distutils-r1

RDEPEND="dev-python/pyside
	 dev-python/nose
	 dev-python/pyscard
	 dev-python/pbkdf2"

DEPEND="${RDEPEND}"

src_prepare()
{
	epatch "${FILESDIR}/yubioath-desktop-0.1.1.patch" || die
}

src_install()
{
	distutils-r1_src_install || die
	domenu resources/yubicoauthenticator.desktop || die
	doicon resources/yubicoauthenticator.xpm || die
}

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
	 dev-python/pycrypto
	 dev-python/pyscard
	 dev-python/pbkdf2"

DEPEND="${RDEPEND}"

src_install()
{
	distutils-r1_src_install || die
	domenu resources/yubioath.desktop || die
	doicon resources/yubioath.xpm || die
}

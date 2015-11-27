# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="firmware for Hauppauge PVR-x50 and Conexant 2341x based cards"
HOMEPAGE="http://www.ivtvdriver.org/index.php/Firmware"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="Hauppauge-Firmware"
KEYWORDS="amd64 ppc x86"
SLOT=0
IUSE=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir /lib/firmware
	insinto /lib/firmware
	doins *.fw
	doins *.mpg
}

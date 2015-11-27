# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN=RT61_Firmware
MY_P=${MY_PN}_V${PV}

DESCRIPTION="Firmware for Ralink rt61-based PCI/PCMCIA WiFi adapters (rt61pci module)"
HOMEPAGE="http://www.ralinktech.com/ralink/Home/Support/Linux.html"
SRC_URI="http://www.ralinktech.com.tw/data/${MY_P}.zip"

LICENSE="ralink-firmware"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

S=${WORKDIR}/${MY_P}

src_install() {
	insinto /lib/firmware
	doins *.bin
}

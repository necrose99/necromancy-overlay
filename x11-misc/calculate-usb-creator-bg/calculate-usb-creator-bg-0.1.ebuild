# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=3
inherit eutils

DESCRIPTION="Инструмент за създаване на зареждащ (Calculate Linux create) USB FLASH."
HOMEPAGE="https://github.com/sandikata/"
SRC_URI=""

LICENSE=""
SLOT="stable"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=x11-misc/xdialog-2.3.1"
RDEPEND="${DEPEND}"

src_install() {
	cd "${FILESDIR}"
	dobin calculate-usb-creator-bg
	doicon "${FILESDIR}"/calculate-usb-creator.png
	domenu "${FILESDIR}"/calculate-usb-creator.desktop
}

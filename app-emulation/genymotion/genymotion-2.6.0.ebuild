# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="Genymotion is a fast and easy-to-use Android emulator to run and test your Android apps"
HOMEPAGE="https://www.genymotion.com"

install_filename="
	amd64? (
		${P}_x64.bin
	)
	x86? (
		${P}_x86.bin
	)
"
SRC_URI="
	amd64? (
		http://files2.genymotion.com/${PN}/${P}/${P}_x64.bin
	)
	x86? (
		http://files2.genymotion.com/${PN}/${P}/${P}_x86.bin
	)
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} virtual/opengl media-libs/libpng:1.2 || ( >=app-emulation/virtualbox-4.3.18 >=app-emulation/virtualbox-bin-4.3.18 )"

S=${DISTDIR}

src_install() {
	mkdir "${D}/opt"

	if use amd64; then
		yes | bash ${P}_x64.bin -d "${D}/opt"
	elif use x86; then
		yes | bash ${P}_x86.bin -d "${D}/opt"
	fi

	mkdir -p "${D}/usr/bin"
	ln -s "/opt/genymotion/genymotion" "${D}/usr/bin" 
	ln -s "/opt/genymotion/genymotion-shell" "${D}/usr/bin" 
	make_desktop_entry genymotion "Genymotion" "/opt/genymotion/icons/icon.png" "System;Emulator"
}

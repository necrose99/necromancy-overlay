# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils
DESCRIPTION="Free calls, text and picture sharing with anyone, anywhere!"
HOMEPAGE="http://www.viber.com"
SRC_URI="http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb"

SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="strip"
S="${WORKDIR}"

src_unpack() {
	default_src_unpack
	unpack ./data.tar.gz
	epatch "${FILESDIR}/viber-9999-desktop.patch"
}

src_install(){
	doins -r opt usr
	fperms 755 /opt/viber/Viber
}

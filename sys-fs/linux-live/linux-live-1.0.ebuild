# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Some functions like tgz2mo, mo2dir, dir2mo, etc."
HOMEPAGE="http://www.linux-live.org"
SRC_URI="http://www.pentoo.ch/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dolib lib/*
	dosbin sbin/*
}

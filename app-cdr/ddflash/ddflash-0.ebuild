# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=3

DESCRIPTION="Console interface with progress indicator to the "dd" program for recording boot live flash "
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/pv
		sys-apps/coreutils"
RDEPEND="${DEPEND}"

src_install() {
	cd "${FILESDIR}"
	dobin ddflash-final
}

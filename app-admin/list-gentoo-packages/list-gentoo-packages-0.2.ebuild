# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# http://nikita.melnichenko.name/blog.php?id=13&topic=gentoo-list-installed-packages-with-use-flags
# necrose99 and yes this is so blasted handy for support issues. 
EAPI=2

inherit eutils

DESCRIPTION="List all installed Gentoo packages with USE flags"
HOMEPAGE="http://nikita.melnichenko.name"
SRC_URI="http://nikita.melnichenko.name/download.php?q=list-gentoo-packages.sh-v0.2
https://raw.githubusercontent.com/necrose99/scripts/master/gentoo-list-installed-packages-with-use-flags/list-gentoo-packages.sh"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""
DEPEND=""
RDEPEND=""

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}
}

src_install() {
	dobin list-gentoo-packages.sh
}

pkg_postinst() {
	elog "list-gentoo-packages.sh installed ,note this will List Everything & the kitchen sink to the terminal"
	elog "list-gentoo-packages.sh (ie pipe with | more/less etc. or redirect with > to mypackages.txt etc) "
	elog "http://nikita.melnichenko.name/blog.php?id=13&topic=gentoo-list-installed-packages-with-use-flags"
}
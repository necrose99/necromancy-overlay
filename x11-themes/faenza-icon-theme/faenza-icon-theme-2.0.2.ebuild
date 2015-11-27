# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="This icon theme is for KDE"
HOMEPAGE="https://kde-look.org"
SRC_URI="https://github.com/manson9/${PN}/archive/master.tar.gz -> ${P}.tar.gz"
LICENSE="Creative Commons by-nc-sa"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""

RDEPEND="${DEPEND}"

src_unpack() {
unpack "${A}"
mv "${PN}-master" "${P}"
}
src_install() {
insinto /usr/share/icons
doins -r FaenzaFlattr2-DarkBreeze FaenzaFlattr2-DarkDeco FaenzaFlattr2-Green FaenzaFlattr2
dodoc README.md
}

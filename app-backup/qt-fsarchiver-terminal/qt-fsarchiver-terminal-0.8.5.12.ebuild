# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils versionator

MIN_PV="$(get_version_component_range 1-3)"

DESCRIPTION="qt-fsarchiver-terminal backend for qt-fsarchiver a QT Gui for FSarchiver, permiting user opps." 
HOMEPAGE="https://sourceforge.net/projects/qt-fsarchiver/"
SRC_URI="mirror://sourceforge/project/qt-fsarchiver/${PN}/source/${P}-0.tar.gz"
#
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~arm64"

IUSE=""

CDEPEND=""
RDEPEND="${CDEPEND}
	>=app-backup/fsarchiver-${MIN_PV}[lzma,lzo]"
DEPEND="${CDEPEND}"

S="${WORKDIR}/${PN}"



src_compile() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs

}

pkg_postinst() {
	elog "qt-fsarchiver-terminal merged."

}


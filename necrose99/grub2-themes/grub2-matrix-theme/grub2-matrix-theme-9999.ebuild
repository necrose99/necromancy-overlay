# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit git-2 grub2-theme

DESCRIPTION="Grub2 matrix theme"
HOMEPAGE="http://kde-look.org/content/show.php/matrix+theme+for+grub?content=151010"
#EGIT_REPO_URI="${FILES}/grub2-matrix-theme.tar.gz"
# http://dl.dropbox.com/u/80562560/grub%20matrix%20theme/grub2-matrix-theme.tar.gz
LICENSE="Creative Commons by-sa"  
SLOT="9999"
KEYWORDS="~amd64 ~x86"  # despite live ebuild
IUSE=""
SRC_URI="${FILES}/grub2-matrix-theme.tar.gz"
src_install() {
	insinto "${GRUB2_THEME_DIR}"/${PN}
	doins -r ${PN}

	dodoc README.md
}

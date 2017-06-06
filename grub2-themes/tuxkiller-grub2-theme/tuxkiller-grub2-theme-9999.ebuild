# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


inherit git-2 grub2-theme

DESCRIPTION="Tuxkiller V2 Grub2 Theme"
HOMEPAGE="http://kde-look.org/content/show.php/Grub2+Theme+Tuxkiller+V2?content=169523"
SRC_URI="${FILES}/grub2_theme_tuxkiller_v2_by_jbaseb-d8o0ix5.zip"

LICENSE="GPL"  
SLOT="9999"
KEYWORDS="~amd64 ~x86"  # despite live ebuild
IUSE=""

src_install() {
	insinto "${GRUB2_THEME_DIR}"/${PN}
	doins -r ${PN}

	dodoc README.md
}

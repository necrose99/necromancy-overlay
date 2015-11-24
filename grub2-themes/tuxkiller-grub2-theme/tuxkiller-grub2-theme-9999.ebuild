# Copyright open-overlay 2015 by Alex

EAPI="5"

inherit git-2 grub2-theme

DESCRIPTION="Tuxkiller V2 Grub2 Theme"
HOMEPAGE="http://kde-look.org/content/show.php/Grub2+Theme+Tuxkiller+V2?content=169523"
EGIT_REPO_URI="git://github.com/pantera31752/tuxkiller-grub2-theme.git"

LICENSE="GPL"  
SLOT="9999"
KEYWORDS="~amd64 ~x86"  # despite live ebuild
IUSE=""

src_install() {
	insinto "${GRUB2_THEME_DIR}"/${PN}
	doins -r ${PN}

	dodoc README.md
}

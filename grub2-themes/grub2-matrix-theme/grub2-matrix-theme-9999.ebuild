# Copyright open-overlay 2015 by Alex

EAPI="5"

inherit git-2 grub2-theme

DESCRIPTION="Grub2 matrix theme"
HOMEPAGE="http://kde-look.org/content/show.php/matrix+theme+for+grub?content=151010"
EGIT_REPO_URI="git://github.com/pantera31752/grub2-matrix-theme.git"

LICENSE="Creative Commons by-sa"  
SLOT="9999"
KEYWORDS="~amd64 ~x86"  # despite live ebuild
IUSE=""

src_install() {
	insinto "${GRUB2_THEME_DIR}"/${PN}
	doins -r ${PN}

	dodoc README.md
}

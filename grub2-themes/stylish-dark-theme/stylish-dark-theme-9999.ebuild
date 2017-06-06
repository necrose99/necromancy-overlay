# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit git-2 grub2-theme

DESCRIPTION="Stylish Dark Grub2 Theme"
HOMEPAGE="http://gnome-look.org/content/show.php/Grub-themes-stylishdark?content=169955"
SRC_URI="https://github.com/necrose99/necromancy-overlay/blob/master/grub2-themes/stylish-dark-theme/files/grub_themes_stylishdark_0_1_by_vinceliuice-d8t31ig.7z"

LICENSE="GPL"  
SLOT="9999"
KEYWORDS="~amd64 ~x86"  # despite live ebuild
IUSE=""
DEPEND="app-arch/p7zip"

src_install() {
	insinto "${GRUB2_THEME_DIR}"/${PN}
	doins -r ${PN}

	dodoc README.md
}

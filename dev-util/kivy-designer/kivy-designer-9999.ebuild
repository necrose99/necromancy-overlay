# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils git-2


DESCRIPTION="Kivy Designer is Kivy's tool for designing graphical user interfaces (GUIs) from Kivy Widgets."
HOMEPAGE="https://github.com/kivy/kivy-designer"
LICENSE="MIT"
KEYWORDS=""
IUSE=""
EGIT_REPO_URI="git://github.com/kivy/kivy-designer.git"

SLOT="0"

RDEPEND=">=dev-python/Kivy-1.9.0-r1
         >=dev-python/pygments-2.0.1-r1
         dev-python/docutils
         >=dev-python/watchdog-0.8.1
         >=dev-python/jedi-0.9.0
         >=dev-python/git-python-1.0.0
         >=dev-python/six-1.10.0
         dev-python/kivy-garden"

DEPEND="${RDEPEND}"

S="${WORKDIR}"
EGIT_CHECKOUT_DIR=${S}

pkg_postinst() {
             einfo "To install the FileBrowser, enter a console:"
             einfo "garden install filebrowser"
}


src_install() {
              insinto "/opt/${PN}"
	      doins -r *
              exeinto "/usr/bin"
              doexe "${FILESDIR}/kivy-designer"
	      insinto "/usr/share/applications"
	      doins "${FILESDIR}/kivy-designer.desktop" 
}

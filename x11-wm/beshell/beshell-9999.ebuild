# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base git-2
EGIT_REPO_URI="git://git.code.sf.net/p/be-shell/code"

DESCRIPTION="Just a Desktop-Shell with kde-base/kwin as window manager."
HOMEPAGE="http://sourceforge.net/p/be-shell/wiki/Home/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="$(add_kdebase_dep kwin)"
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/be.shell
	doins plasma-desktop.desktop krunner.desktop

	kde4-base_src_install
}

pkg_postinst() {
	einfo "The easiest way to start beshell is to use startkde."
	einfo "This will automatically start all services from"
	einfo "/usr/share/autostart"
	einfo "If you have installed plasma-desktop and krunner,"
	einfo "those will get startet, too."
	einfo "beshell is aimed to be a lightweight replacement for those."
	einfo "In order to suppress loading of plasma-desktop and krunner,"
	einfo "just copy the files installed in /usr/share/be.shell"
	einfo "to ~/.kde4/share/autostart/"
	einfo "In order to get plasma-desktop and krunner back,"
	einfo "simply remove the files again."
	
	einfo "beshell does not provide a GUI for configuration (at least not for"
	einfo "all options). To see what you can do have a look the wiki:"
	einfo "http://sourceforge.net/p/be-shell/wiki/browse_pages/"
}

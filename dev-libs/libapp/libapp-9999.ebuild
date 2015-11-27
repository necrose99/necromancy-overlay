# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="git://github.com/drotiro/${PN}.git
	http://github.com/drotiro/${PN}.git"
inherit git-2 multilib

DESCRIPTION="Utilities for repetitive tasks in app development"
HOMEPAGE="https://github.com/drotiro/libapp"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

src_install() {
	emake INSTALL_S="install" LIBDIR="\$(PREFIX)/$(get_libdir)" PREFIX="${D}/usr" install
	dodoc -r test/
}

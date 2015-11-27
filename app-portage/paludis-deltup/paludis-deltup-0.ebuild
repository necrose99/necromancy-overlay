# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils

DESCRIPTION="Deltup service integration for Paludis PM"
HOMEPAGE="http://linux01.gwdg.de/~nlissne/"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE=""


RDEPEND="sys-apps/paludis
	app-portage/getdelta"

DEPEND="${RDEPEND}"

src_install() {
	dobin ${FILESDIR}/getdelta-paludis.sh

	exeinto /usr/share/paludis/fetchers
	doexe ${FILESDIR}/dohttp
}

pkg_postinst() {
	einfo "To use deltup with paludis add the following to '/etc/paludis/bashrc':"
	einfo "export DELTUP='/usr/bin/getdelta-paludis.sh'"
	einfo "export USE_GETDELTA='yes'"
}

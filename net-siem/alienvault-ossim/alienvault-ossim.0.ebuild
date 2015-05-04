# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosip/libosip-4.0.0.ebuild,v 1.4 2013/08/18 13:25:30 ago Exp $
# git-r3_fetch inherit git-3 old asembla repo is dust atm. 
## Michael R LAwrencce mike@michaellawrenceit.com (Necrose99)  this is a templative ebuild,  I will need requirements to finish working.
EAPI="5"

inherit eutils versionator

MY_PV=${PV%.?}-${PV##*.}
MY_PV=${PV}
MY_P=${PN}2-${MY_PV}
DESCRIPTION="AlienVault's Open SIEM"
HOMEPAGE="https://www.alienvault.com/open-threat-exchange/projects"
SRC_URI="mirror://gnu/osip/${MY_P}.tar.gz"
#http://downloads.alienvault.com/c/download?version=current_ossim_source alienvault-ossim_4.15.2 (1).tar.gz

LICENSE="LGPL-2"
SLOT="2/$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~ppc-macos ~x86-macos"
IUSE="debug doc examples minimal ntp-timestamp ssl"

RDEPEND="ssl? ( dev-libs/openssl:0= )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	virtual/pkgconfig"
S=${WORKDIR}/${MY_P}

src_configure() {
	econf --enable-mt \
		$(use_enable test)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog FEATURES HISTORY README NEWS TODO
}

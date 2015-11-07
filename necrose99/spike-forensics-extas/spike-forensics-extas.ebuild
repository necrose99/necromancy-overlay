# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="3"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Spike meta-ebuild for xfce flavour"
HOMEPAGE="http://www.spike-pentesting.org"
SLOT="0"
LICENSE="GPL"
IUSE=""

S="${WORKDIR}"

DEPEND="sys-apps/dcfldd
"
RDEPEND="${DEPEND}"
pkg_install(){
einfo "Meta ebuild for extra forensic toys"
}

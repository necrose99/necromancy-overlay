# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-9999.ebuild,v 1.328 2015/06/10 02:37:44 floppym Exp $

EAPI=5
inherit python-any-r1 git-3
PYTHON_COMPAT=( python2_7 )
MY_PN="veil-evasion"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/Veil-Framework/Veil-Evasion.git"
	EGIT_BRANCH="master"
	inherit git-r3
	SRC_URI=""
	#KEYWORDS=""
else
	MY_P="${MY_PN}-${PV/_/-}"
	SRC_URI="https://github.com/Veil-Framework/${MY_PN}//archive//${MY_P}.tar.gz" 
	KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
	S="${WORKDIR}/${MY_P}"
fi

DESCRIPTION="Veil-Catapult is a payload delivery tool that integrates with Veil-Evasion"
GO_PN="github.com/hashicorp/${PN}"
HOMEPAGE="https://www.veil-framework.com/"
LICENSE="MPL-2.0"
SLOT="0"
IUSE="test"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/impacket "
RDEPEND="${DEPEND}"

S="${WORKDIR}/veil-catapult-${PV}/veil-catapult"

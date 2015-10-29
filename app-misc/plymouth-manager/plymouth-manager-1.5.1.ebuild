# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 flag-o-matic autotools

if [[ ${PV} = 9999 ]]; then
	inherit bzr 
fi
	if [[ ${PV} == "9999" ]] ; then
	EBZR_REPO_URI="https://code.launchpad.net/~mefrio-g/plymouth-manager/plymouth-manager"	
	inherit autotools bzr
	BZR_BOOTSTRAP=""
	SRC_URI=""	
else
	SRC_URI="mirror://sourceforge/${PN}/source/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
DESCRIPTION="plymouth manager AGraphical  boot animation Theme tool"
HOMEPAGE="http://plymouthmanager.wordpress.com/
https://translations.launchpad.net/plymouth-manager/"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="~dev-python/pygtk
 x11-libs/libdrm
 dev-util/debhelper
 sys-boot/plymouth/
 dev-util/pkgconfig
 dev-util/quilt
 app-arch/sharutils
 media-libs/libpng"
	
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}/"





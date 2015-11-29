# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils cmake-utils 
if [[ ${PV} = 9999 ]]; then
	SCM=git-r3
	EGIT_REPO_URI="https://code.pinguin.lu/diffusion/XMOUNT/xmount.git"
	EGIT_BOOTSTRAP=""
else
	SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/xmount_${PV}.orig.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.pinguin.lu/xmount"

LICENSE="GPL-3"
SLOT="0"
IUSE="+aff +ewf"
KEYWORDS="~amd64 ~x86 ~arm ~arm64 ~powerpc ~ppc64el"


RDEPEND="sys-fs/fuse
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

#prepare: we might need files/cmake_c_flags patch on hardened

src_configure() {
	CMAKE_BUILD_TYPE=Release
	cmake-utils_src_configure
}

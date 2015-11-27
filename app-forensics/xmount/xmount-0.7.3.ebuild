# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
SCM=

if [[ ${PV} = 9999 ]]; then
	SCM=git-r3
	EGIT_REPO_URI="https://code.pinguin.lu/diffusion/XMOUNT/xmount.git"
	EGIT_BOOTSTRAP=""
fi
CMAKE_BUILD_TYPE=Release

inherit cmake-utils ${SCM} multilib

DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.pinguin.lu/xmount"

if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	SRC_URI="http://files.pinguin.lu/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+aff +ewf"

RDEPEND="sys-fs/fuse
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e "s#lib/xmount#$(get_libdir)/xmount#g" $(find -name CMakeLists.txt) || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_LibAFF=$(usex !aff)
		-DCMAKE_DISABLE_FIND_PACKAGE_LibEWF=$(usex !ewf)
	)

	cmake-utils_src_configure
}
src_install() {
 cmake-utils_src_install
 }

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils git-r3 multilib
DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.pinguin.lu/xmount"

if [[ ${PV} = 9999 ]]; then
	SCM=git-r3
	EGIT_REPO_URI="https://code.pinguin.lu/diffusion/XMOUNT/xmount.git"
	EGIT_BOOTSTRAP=""
	KEYWORDS=""
else
	SRC_URI="SRC_URI="http://files.pinguin.lu/${P}.tar.gz""
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+aff +ewf"

RDEPEND="sys-fs/fuse
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!!xmount-bin"

S=${WORKDIR}/${PV}

src_unpack() {
	if [[ ${PV} != *9999 ]]; then
		default
	else
		unpack ${MY_P}.tar.bz2

		fi
}

src_configure() 
{ local mycmakeargs=(-DBUILD_REDIST_PACKAGE=$(usex bindist) -DWANT_afflib=$(usex afflib) -DWANT_libewf=$(usex libewf) -DCMAKE_BUILD_TYPE=Release); 
cmake-utils_src_configure; 
CMAKE_USE_DIR="${S}/src"
}


#mkdir build
#cd build
#cmake -DCMAKE_BUILD_TYPE=Release ..
#make
#make install
#/xmount-0.7.3/src/CMakeLists.txt

src_install() {
	mkdir ${MY_P}/build
	cd ${MY_P}/build
	cmake-utils_src_make
	cmake-utils_src_install
	# install a default configuration file
	dodoc README CHANGELOG VERSION
	insinto /usr/bin/
	doins "${FILESDIR}"/xmount-*
	dobin xmount-*
}

pkg_postinst() {
	einfo "Xmount Installed"
}

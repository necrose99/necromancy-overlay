# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $ Necrose99 for a Quick stab at tinkering on new version test $ 

EAPI=5
inherit cmake-utils git-3 multilib
DESCRIPTION="Convert on-the-fly between multiple input and output harddisk image types"
HOMEPAGE="https://www.pinguin.lu/xmount"
## https://code.pinguin.lu/diffusion/XMOUNT/browse/master/trunk/CMakeLists.txt
if [[ ${PV} = 9999 ]]; then
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

#unable to build, see the upstream bug: https://www.pinguin.lu/node/16
KEYWORDS=""

RDEPEND="sys-fs/fuse
	aff? ( app-forensics/afflib )
	ewf? ( app-forensics/libewf )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare(){
	sed -e "s#LIBS = \@LIBS\@#LIBS = \@LIBS\@ -lz#" \
		-i Makefile.in
}

src_configure() {
	use aff || export ac_cv_lib_afflib_af_open=no
	use ewf || export ac_cv_lib_ewf_libewf_open=no
	econf
}

 ----------------- Need to Addapt to Xmount and replace above when time permits.
  #cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release ..
 # make
src_configure() {
    local mycmakeargs=(
        $(cmake-utils_use_build bindist  REDIST_PACKAGE)
        $(cmake-utils_use_build c_sync   C_SYNC)
    )
    cmake-utils_src_configure
}




src_install() {
	cmake-utils_src_install
	# install a default configuration file
	dodoc README CHANGELOG VERSION
	insinto /etc/vim
	doins "${FILESDIR}"/xmount-*
	dobin xmount-*
}

pkg_postinst() {
	einfo "Xmount Installed"
}

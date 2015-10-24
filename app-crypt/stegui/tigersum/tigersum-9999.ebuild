## !!! Warning ebuild is speculative and in pre-alpha template stage... 

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils dlang versionator multilib-build git-r3 cmake-utils

DESCRIPTION="A command line hashing program based on the tiger algorithm""
HOMEPAGE="https://bitbucket.org/King_DuckZ/tigersum/"
EGIT_REPO_URI="git@bitbucket.org:King_DuckZ/tigersum.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="${COMMON_RDEPEND}
	>=app-admin/eselect-dlang-20140709
	virtual/pkgconfig"
	
RDEPEND="${DEPEND}

cmake -DCMAKE_BUILD_TYPE=Release <path_to_tigersum_source>
make -j2
src_prepare() {
	DOCS="AUTHORS MAINTAINERS NEWS" # ChangeLog has nothing useful
	# Do not pass --enable-tests to configure - package has no tests

	gnome2_src_prepare

	# Drop stupid CFLAGS
	# FIXME: doing configure.ac triggers maintainer mode rebuild
	sed -e 's:$CFLAGS -g -O0:$CFLAGS:' \
		-i configure || die "sed failed"
}

pkg_postinst() {
	gnome2_pkg_postinst


S="${WORKDIR}/dmd2"
PREFIX="opt/${PN}-${SLOT}"
IMPORT_DIR="/${PREFIX}/import"




 ----------------- Need to Addapt to tigersum and replace above when time permits.
  #cmake -DCMAKE_BUILD_TYPE=Release <path_to_tigersum_source>
# make -j2
src_configure() {
    local mycmakeargs=(
        $(cmake-utils_use_build bindist  REDIST_PACKAGE)
        $(cmake-utils_use_build c_sync   C_SYNC)
        $(cmake-utils_use_build cpp      CPP)
        $(cmake-utils_use_build examples EXAMPLES)
        $(cmake-utils_use_build fakenect FAKENECT)
        $(cmake-utils_use_build opencv   CV)
        $(cmake-utils_use_build openni2  OPENNI2_DRIVER)
        $(cmake-utils_use_build python   PYTHON)
    )
    cmake-utils_src_configure
}

src_install() {
    cmake-utils_src_install
    
    # udev rules
    insinto /lib/udev/rules.d/
    doins "${S}"/platform/linux/udev/51-kinect.rules
    
------------------------------    
    src_configure() {
	export USE_BUNDLED_DEPS=OFF
	append-cflags "-Wno-error"
	append-cppflags "-DNDEBUG -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1"
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DLIBUNIBILIUM_USE_STATIC=OFF
		-DLIBTERMKEY_USE_STATIC=OFF
		-DLIBVTERM_USE_STATIC=OFF
		)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	# install a default configuration file
	insinto /etc/vim
	doins "${FILESDIR}"/nvimrc
}
	"${ROOT}"/usr/bin/eselect dlang update dmd
}

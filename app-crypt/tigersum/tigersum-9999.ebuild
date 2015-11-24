# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$  live ebuild Necrose99 

EAPI=5
inherit eutils dlang versionator multilib-build git-r3 cmake-utils

DESCRIPTION="A command line hashing program based on the tiger algorithm""
HOMEPAGE="https://bitbucket.org/King_DuckZ/tigersum/"
EGIT_REPO_URI="git@bitbucket.org:King_DuckZ/${PN}.git"
EGIT_CHECKOUT_DIR=${WORKDIR}/${PN}
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+dlang"
DEPEND="${RDEPEND}
	>=app-admin/eselect-dlang-20140709
	virtual/pkgconfig"

RDEPEND="${DEPEND}
dlang? ( || ( dev-lang/dmd  dev-lang/dmd-bin dev-util/gdmd ) )"
#@ bitbucket.org/King_DuckZ/tigersum Any D-Compiler will do.


S="${WORKDIR}/${PN}"
PREFIX="/usr/bin/${PN}-${SLOT}"
IMPORT_DIR="/${PREFIX}/import"

#cmake -DCMAKE_BUILD_TYPE=Release <path_to_tigersum_source>
# make -j2
src_configure() {
    local mycmakeargs=(
        $(cmake-utils_use_build bindist  REDIST_PACKAGE)
    )
    cmake-utils_src_configure
}

src_install() {
    cmake-utils_src_install
    
    # udev rules
    insinto /usr/bin/tigersum
    doins "${S}"/usr/bin/tigersum
    }
    
    elog="tigersum installed"

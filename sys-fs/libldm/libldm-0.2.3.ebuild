# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Tool for managing windows's LDM partitions"
HOMEPAGE="https://github.com/mdbooth/libldm"
SRC_URI="https://github.com/mdbooth/libldm/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="mirror"
DEPEND="dev-util/gtk-doc"

inherit autotools flag-o-matic

src_prepare() {
    # Remove problematic LDFLAGS declaration
    sed -i -e 's/ -Werror//g' src/Makefile.am || die
    #filter-flags -Wall
    #strip-flags
    #append-flags -Wno-error
    eautoreconf
}

src_unpack() {
    unpack ${A}
    mv "libldm-${P}" "${P}"
}

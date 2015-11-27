# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils git-2

DESCRIPTION="Library for TI calculator files"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/debrouxl/tilibs.git"

MY_PN="libtifiles"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc nls static-libs"

RDEPEND="
	app-arch/libarchive
	dev-libs/glib:2
	>=sci-libs/libticables2-1.3.3
	>=sci-libs/libticonv-1.1.3
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS LOGO NEWS README ChangeLog docs/api.txt )

src_prepare() {
	S="${S}/${MY_PN}/trunk/"
	cd ${S}

	eautoreconf
}

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	default
	use doc && dohtml docs/html/*
}

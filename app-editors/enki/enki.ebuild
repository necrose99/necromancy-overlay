Close

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monkeystudio/monkeystudio-1.9.0.4.ebuild,v 1.4 2014/11/20 00:27:01 pesa Exp $

EAPI=5
LANGS="be es fr ru"

inherit qt4-r2

MY_P="mks_${PV}-src"

DESCRIPTION="A cross platform Qt 4 IDE"
HOMEPAGE="http://www.monkeystudio.org"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc plugins"

RDEPEND="
	dev-qt/designer:4
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qthelp:4
	dev-qt/qtsql:4
	x11-libs/qscintilla:=
	plugins? ( dev-qt/qtwebkit:4 )
"
DEPEND="${RDEPEND}
	doc? ( >=app-doc/doxygen-1.5.8 )
"

PATCHES=( "${FILESDIR}/${P}-install.patch" )
DOCS=( ChangeLog readme.txt )

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Revert upstream change designed to permit shadow building
	# which is causing build failure
	sed -e '/PACKAGE_BUILD_PATH  = $$(PWD)\/build/d' \
		-e 's/#PACKAGE_BUILD_PATH/PACKAGE_BUILD_PATH/' \
		-i config.pri || die

	rm -r qscintilla/QScintilla-gpl-snapshot \
		|| die "failed removing bundled qscintilla"

	qt4-r2_src_prepare
}

src_configure() {
	eqmake4 prefix=/usr system_qscintilla=1

	if use plugins ; then
		eqmake4 plugins/plugins.pro
	fi
}

src_install() {
	qt4-r2_src_install

	if use plugins ; then
		insinto /usr/lib64/monkeystudio
		doins -r bin/plugins/*
	fi

	insinto /usr/share/${PN}/translations
	local lang
	for lang in ${LANGS} ; do
		if use linguas_${lang} ; then
			doins datas/translations/monkeystudio_${lang}.qm
		fi
	done

	fperms 755 /usr/bin/${PN}

	if use doc ; then
		doxygen || die "doxygen failed"
		dohtml -r doc/html/*
	fi
}



# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leafpad/leafpad-0.8.18.1.ebuild,v 1.6 2014/09/13 21:53:07 tristan Exp $

EAPI=5
inherit eutils fdo-mime gnome2-utils

DESCRIPTION="A simple GTK2 text editor"
HOMEPAGE="http://tarot.freeshell.org/leafpad/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="emacs"

RDEPEND="virtual/libintl
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-fdo.patch \
		"${FILESDIR}"/${P}-format-security.patch
}

src_configure() {
	econf \
		--enable-chooser \
		--enable-print \
		$(use_enable emacs)
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

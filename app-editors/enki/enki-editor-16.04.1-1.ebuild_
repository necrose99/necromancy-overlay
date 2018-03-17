# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# $Header: /var/cvsroot/gentoo-x86/dev-util/monkeystudio/monkeystudio-1.9.0.4.ebuild,v 1.4 2014/11/20 00:27:01 pesa Exp $

EAPI=5
LANGS="be es fr ru"

inherit eutils qt4-build-multilib

MY_P="mks_${PV}-src"

DESCRIPTION="Enki is a text editor for programmers"
HOMEPAGE="http://enki-editor.org/"
#http://download.opensuse.org/repositories/home:/hlamer:/enki/Debian_8.0/all/enki_16.04.1-1~obs1_all.deb
install_filename="
	amd64? (
		${P}_x64.bin
	)
	x86? (
		${P}_x86.bin
	)
"
SRC_URI="
	amd64? (
		http://download.opensuse.org/repositories/home:/hlamer:/enki/Debian_8.0/amd64/python3-qutepart_3.0.1-1~obs1_amd64.deb
    #${PN}/${P}/${P}_x64.bin
	)
	x86? (
		http://download.opensuse.org/repositories/home:/hlamer:/enki/Debian_8.0/i386/python3-qutepart_3.0.1-1~obs1_i386.deb
    #${PN}/${P}/${P}_x86.bin
	)
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="
SRC_URI="http://download.opensuse.org/repositories/home:/hlamer:/enki/Debian_8.0/all/${PV}~obs1_all.deb -> ${P}.deb"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86  ~amd64-linux ~x86-linux"
IUSE="doc plugins"

RDEPEND="
	dev-qt/designer:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qthelp:5
	dev-qt/qtsql:5
	dev-python/pyparsing 
	qutepart?
	>=dev-lang/python-3
	dev-python/PyQt5
	dev-python/flake8
	dev-python/markdown
"
DEPEND="${RDEPEND}
	doc? ( >=app-doc/doxygen-1.5.8 )
"


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

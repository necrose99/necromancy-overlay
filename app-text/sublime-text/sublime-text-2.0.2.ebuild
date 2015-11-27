# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils

S="${WORKDIR}/Sublime Text 2"

DESCRIPTION="Sublime Text is a sophisticated text editor for code, html and prose"
HOMEPAGE="http://www.sublimetext.com"
SRC_URI="amd64? ( http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2%20x64.tar.bz2 -> ${P}-amd64.tar.bz2 )
	x86? ( http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%202.0.2.tar.bz2 -> ${P}-x86.tar.bz2 )"
LICENSE="Sublime"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

QA_PRESTRIPPED="/opt/${PN}/sublime_text"
RDEPEND="media-libs/libpng
	>=x11-libs/gtk+-2.24.8-r1:2"

src_install() {
        local dir="/opt/${PN}"
	insinto "${dir}"
	doins -r *
        fperms 755 "${dir}/sublime_text"
	dosym "/opt/${PN}/sublime_text" /usr/bin/sublime
	make_desktop_entry "sublime" "Sublime Text Editor" "accessories-text-editor" "Development"
}

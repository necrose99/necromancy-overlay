# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$


inherit eutils l10n

DESCRIPTION="Translation data for Cinnamon"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/cinnamon-translations/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT="test" # tests are for upstream translators and need network access

src_prepare() {
	epatch_user
}

src_configure() { :; }

src_install() {
	# Cannot run before since locales are not in the expected place for this to work
	l10n_find_plocales_changes "${S}"/usr/share/locale "" ""

	install_locale() {
		dodir /usr/share/locale
		insinto /usr/share/locale
		doins -r usr/share/locale/${1}
	}
	l10n_for_each_locale_do install_locale
}

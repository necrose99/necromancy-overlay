# Copyright open-overlay 2015 by Alex

EAPI="5"

EGIT_REPO_URI="git://subsurface-divelog.org/subsurface.git"
KEYWORDS=""
LIBDC_V="0.4.2"

PLOCALES="bg_BG da_DK de_CH de_DE el_GR en_GB es_ES et_EE fi_FI fr_FR he hu it_IT
	lv_LV nb_NO nl_NL pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sv_SE tr zh_TW
"

inherit eutils l10n qt4-r2 git-r3

DESCRIPTION="An open source dive log program"
HOMEPAGE="http://subsurface.hohndel.org"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug doc usb"

RDEPEND="dev-db/sqlite:3
	dev-libs/glib:2
	>=dev-libs/libdivecomputer-${LIBDC_V}[usb?]
	dev-libs/libgit2:=
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/libzip
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	kde-base/marble:4
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-text/asciidoc )
"

DOCS="README"

src_unpack() {
	git-r3_src_unpack
}

rm_trans() {
	rm "${ED}/usr/share/${PN}/translations/${PN}_${1}.qm" || die "rm ${PN}_${1}.qm failed"
}

src_install() {
	qt4-r2_src_install

	l10n_for_each_disabled_locale_do rm_trans

	# this is not a translation but present (no need to die if not present)
	rm "${ED}/usr/share/${PN}/translations/${PN}_source.qm"

	if ! use doc; then
		rm -R "${ED}/usr/share/${PN}/Documentation"* || die "rm doc failed"
	fi
}

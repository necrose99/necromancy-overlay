# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#MY_P="${PN}-$(replace_version_separator 3 '-')"
# MIN_PV="$(get_version_component_range 1-3)"
# $Header: $

EAPI="5"

inherit  versionator eutils multilib flag-o-matic toolchain-funcs

MY_P="${PN}-$(replace_version_separator 3 '-')"

DESCRIPTION=" SteGUIa program with a graphical interface for easy operation the Steghide Stenography tool"
HOMEPAGE="http://stegui.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#KEYWORDS="amd64 ppc ppc64 x86"
IUSE="btrfs jfs ntfs reiser4 reiserfs xfs"

DEPEND="dev-cpp/pstreams
	media-libs/libjpeg-turbo
	dev-libs/glib:2
	dev-libs/libgcrypt
	dev-libs/lzo
	x11-libs/fltk
	media-libs/alsa-lib
	app-crypt/mhash
	app-crypt/mcrypt"
RDEPEND="${DEPEND}
	"

	S="${WORKDIR}/${PN}"

src_prepare() {
	# fix .desktop file
	sed -i \
		-e '/Encoding/d' starter/"${PN}".desktop \
		|| die "sed on qt4-fsarchiver.desktop failed"
	# fix icon installation location
	sed -i \
		-e "/icon.path/s:app-install/icons:${PN}:" "${PN}.pro" \
		|| die "sed on ${PN}.pro failed"
}

src_configure() {
	eqmake4 "${PN}".pro OPTION_LZO_SUPPORT=1 OPTION_LZMA_SUPPORT=1
}
src_install() {
	dobin hydrogen
	insinto /usr/share/hydrogen
	doins -r data
	doicon data/img/gray/h2-icon.svg
	domenu hydrogen.desktop
	dosym /usr/share/hydrogen/data/doc /usr/share/doc/${PF}/html
	dodoc AUTHORS ChangeLog README.txt
}
### picked for exmaple function.... 
#pkg_postinst() {
#	elog "optional dependencies:"
#	elog "  sys-fs/btrfs-progs"
#	elog "  sys-fs/jfsutils"
#	elog "  sys-fs/ntfs3g[ntfsprogs]"
#	elog "  sys-fs/reiser4progs"
#	elog "  sys-fs/reiserfsprogs"
#	elog "  sys-fs/sshfs-fuse"
#	elog "  sys-fs/xfsprogs"
#}

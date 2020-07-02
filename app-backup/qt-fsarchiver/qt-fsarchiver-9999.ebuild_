# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils versionator

MIN_PV="$(get_version_component_range 1-3)"

DESCRIPTION="Qt5 frontend for fsarchiver"
HOMEPAGE="http://qt4-fsarchiver.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/qt4-fsarchiver/${PN}/source/${P}-0.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~arm64"

IUSE=""

CDEPEND="app-arch/bzip2
	app-arch/xz-utils
	dev-libs/libgcrypt:=
	dev-libs/lzo
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	sys-apps/util-linux
	sys-fs/e2fsprogs
	sys-libs/zlib"
RDEPEND="${CDEPEND}
	>=app-backup/fsarchiver-${MIN_PV}[lzma,lzo]
	app-backup/qt-fsarchiver-terminal
	"
	### app-backup/qt-fsarchiver-terminal backend for USER operations ie DISKS or sudo etc. 
DEPEND="${CDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch ${FILESDIR}/gentoo-qt-fsarchiver1.patch
	## fix pro , fix desktop.
	epatch ${FILESDIR}/gentoo-qt-fsarchiver2.patch
	sed -i \
		-e "/icon.path/s:app-install/icons:${PN}:" "${PN}.pro" \
		|| die "sed on ${PN}.pro failed"
}

src_compile() {
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
	# remove gksu && kdesu enabled desktop entries
#	rm -rf ${ED}/usr/share/applications/kde-${PN}.desktop
#	rm -rf ${ED}/usr/share/applications/mate-${PN}.desktop
}

pkg_postinst() {
	elog "optional dependencies:"
	elog "  sys-fs/btrfs-progs"
	elog "  sys-fs/jfsutils"
	elog "  sys-fs/ntfs3g[ntfsprogs]"
	elog "  sys-fs/reiser4progs"
	elog "  sys-fs/reiserfsprogs"
	elog "  net-fs/sshfs"
	elog "  sys-fs/xfsprogs"
}

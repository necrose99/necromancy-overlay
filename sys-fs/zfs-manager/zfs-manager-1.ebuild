# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="ZFS Manager is a menu driven utility for managing ZFS Filesystems "
HOMEPAGE="http://downloads.sourceforge.net/project/zfsmanager/"
#SRC_URI="mirror://sourceforge/${PN}/files/ZFS-Man.py"
# SRC_URI="mirror://sourceforge/${PN}/source/ZFS-Man.py"
#https://sourceforge.net/projects/zfsmanager/files/ZFS-Man.py/download
# not pulling cleany so added to overlay copy. 
SRC_URI="${FILESDIR}/ZFS-Man.py"
PYTHON_COMPAT=( python{2_*} )
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""
DEPEND="${RDEPEND}"
RDEPEND="|| ( sys-fs/zfs sys-fs/zfs-fuse sys-fs/zfs-kmod )"



src_install() {
	newins ${FILESDIR}/ZFS-Man.py /usr/bin/zfs-man.py
	fixperms +x /usr/bin/zfs-man.py
	dosym /usr/bin/ZFS-Man.py /usr/bin/zfs-man.py
}

pkg_postinst() {
	elog "Thier is no Official Documentation it is advisable to read  the $HOMEPAGE"
}

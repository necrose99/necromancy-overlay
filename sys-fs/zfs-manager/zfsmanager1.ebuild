# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ # necrose99 and yes this is so blasted handy for support issues. 
# http://nikita.melnichenko.name/blog.php?id=13&topic=gentoo-list-installed-packages-with-use-flags was inspired by.
EAPI=2

inherit eutils

DESCRIPTION="ZFS Manager is a menu driven utility for managing ZFS Filesystems "
HOMEPAGE="http://downloads.sourceforge.net/project/zfsmanager/"
SRC_URI="mirror://sourceforge/${PN}/source/ZFS-Man.py -> zfsmanager.py

http://downloads.sourceforge.net/project/zfsmanager/ZFS-Man.py?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fzfsmanager%2Ffiles%2F&ts=1447266032&use_mirror=iweb
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""
DEPEND=""
RDEPEND=">=dev-lang/python-2.*"



src_install() {
	echo enalyze analyze -u packages >> /usr/bin/zfsmanager.py
	chmode +x /usr/bin/zfsmanager.py
	ln -s /usr/bin/zfsmanager /usr/bin/zfsmanager.py
	
}

pkg_postinst() {
	elog "list-gentoo-packages.sh installed ,note this will List Everything & the kitchen sink to the terminal"
	elog "list-gentoo-packages.sh (ie pipe with | more/less etc. or redirect with > to mypackages.txt etc) "
	elog "enalyze analyze -u packages alias thats easy to rember for novices/lazy, panic of impending drive fail-doom, etc."
	elog "http://nikita.melnichenko.name/blog.php had one that list all flags etc, works still however is somewhat depricated."
}

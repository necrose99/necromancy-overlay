# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="List all installed Gentoo packages with USE flags (easy to rember alias of enalyze..) for novice users"
HOMEPAGE="https://github.com/necrose99/necromancy-overlay"
#SRC_URI="http://nikita.melnichenko.name/download.php?q=list-gentoo-packages.sh-v0.2" 
# url dosent pull down file cleanly and wont manifest properly 
SRC_URI="${files/list-gentoo-packages.sh}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""
DEPEND="${RDEPEND}"
RDEPEND="app-portage/gentoolkit"

einfo "now a touch depricated. so sayeth the Gentoo devs ", 
einfo "however an alias to list ALL packages even unlisted,Libs EVERYTHING with flags"
einfo"Even Still its Very Damned handy fro the average user, and if you have legacy.. boxes also useful... if migrating to newer gentoo"

src_install() {
cp ${files/list-gentoo-packages.sh} /usr/bin/list-gentoo-packages.sh
	fixperms +x /usr/bin/list-gentoo-packages.sh
	dosym /usr/bin/list-gentoo-packages /usr/bin/list-gentoo-packages.sh
	
}

pkg_postinst() {
	elog "list-gentoo-packages.sh installed ,note this will List Everything & the kitchen sink to the terminal"
	elog "list-gentoo-packages.sh (ie pipe with | more/less etc. or redirect with > to mypackages.txt etc) "

}

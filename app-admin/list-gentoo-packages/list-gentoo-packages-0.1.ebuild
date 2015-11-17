# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ # necrose99 and yes this is so blasted handy for support issues. 
# http://nikita.melnichenko.name/blog.php?id=13&topic=gentoo-list-installed-packages-with-use-flags was inspired by.
EAPI=5

inherit eutils

DESCRIPTION="List all installed Gentoo packages with USE flags (easy to rember alias of enalyze..) for novice users"
HOMEPAGE="https://github.com/necrose99/necromancy-overlay"
SRC_URI="http://nikita.melnichenko.name/download.php?q=list-gentoo-packages.sh-v0.2 

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""
DEPEND=""
RDEPEND=""

einfo"now a touch depricated. so sayeth the Gentoo devs , however an alias to list ALL packages even unlisted,Libs EVERYTHING with flags"
einfo"Even Still its Very Damned handy fro the average user,"

src_install() {
	echo enalyze analyze -u packages >> /usr/bin/list-gentoo-packages.sh
	chmode +x /usr/bin/list-gentoo-packages.sh
	ln -s /usr/bin/list-gentoo-packages /usr/bin/list-gentoo-packages.sh
	
}

pkg_postinst() {
	elog "list-gentoo-packages.sh installed ,note this will List Everything & the kitchen sink to the terminal"
	elog "list-gentoo-packages.sh (ie pipe with | more/less etc. or redirect with > to mypackages.txt etc) "
	elog "enalyze analyze -u packages alias thats easy to rember for novices/lazy, panic of impending drive fail-doom, etc."
	elog "http://nikita.melnichenko.name/blog.php had one that list all flags etc, works still however is somewhat depricated."
}

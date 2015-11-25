# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2 eutils

DESCRIPTION="Google cloud print server"
HOMEPAGE="https://github.com/armooo/cloudprint"
EGIT_REPO_URI="git://github.com/armooo/cloudprint"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND=">=dev-lang/python-2.6
	dev-python/pycups"

S=${WORKDIR}/${P}

src_unpack() {
    git-2_src_unpack ${A}
    cd "${S}"
    git checkout master
}

src_install() {
	dodir /var/lib/cloudprint
	dodir /var/log
	touch ${D}/var/log/cloudprint.log
	fowners -R nobody:nobody /var/lib/cloudprint 
	fowners nobody:nobody /var/log/cloudprint.log
	doinitd "${FILESDIR}"/cloudprint
	insinto /usr/$(get_libdir)/cloudprint
	doins cloudprint/*
}

pkg_postinst() {
	elog
	elog "Before starting the service, you must first run /etc/init.d/cloudprint setup to sign in to your google account. "
        elog "To get cloudprint to start automatically, you can add "
        elog "it to the default run level, by running this command as root:"
        elog
        elog "rc-update add cloudprint default"
}


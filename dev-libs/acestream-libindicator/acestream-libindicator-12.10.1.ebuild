# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="A set of symbols and convience functions that all indicators would like to use"
HOMEPAGE="http://launchpad.net/libindicator"
MY_PN="${PN#acestream-}"
SRC_URI="x86? ( https://launchpad.net/ubuntu/+source/libindicator/12.10.1-0ubuntu1/+build/3799239/+files/libindicator7_12.10.1-0ubuntu1_i386.deb )
		amd64? ( https://launchpad.net/ubuntu/+source/libindicator/12.10.1-0ubuntu1/+build/3799239/+files/libindicator7_12.10.1-0ubuntu1_amd64.deb ) "

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.22
	>=x11-libs/gtk+-2.24:2"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare(){
	unpack ${A}
	unpack ./data.tar.gz
}

src_install() {
	dolib usr/lib/libindicator.so.7 usr/lib/libindicator.so.7.0.0
}

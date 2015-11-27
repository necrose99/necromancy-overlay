# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="A library to allow applications to export a menu into the Unity Menu bar"
HOMEPAGE="http://launchpad.net/libappindicator"
MY_PN="${PN#acestream-}"
SRC_URI="amd64? ( https://launchpad.net/ubuntu/+source/libappindicator/12.10.0-0ubuntu1/+build/3649098/+files/libappindicator1_12.10.0-0ubuntu1_amd64.deb )
	x86? ( https://launchpad.net/ubuntu/+source/libappindicator/12.10.0-0ubuntu1/+build/3649098/+files/libappindicator1_12.10.0-0ubuntu1_i386.deb )"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.26
	>=dev-libs/libdbusmenu-12.10.2-r2:0[gtk]
	dev-libs/acestream-libindicator
	>=x11-libs/gtk+-2.24.12:2"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare(){
	unpack ${A}
	unpack ./data.tar.gz
}

src_install() {
	dolib usr/lib/libappindicator.so.1.0.0 usr/lib/libappindicator.so.1
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit flag-o-matic eutils unpacker

DESCRIPTION="Lightweight Window Manager forked from E17"
HOMEPAGE="http://mokshadesktop.org"
SRC_URI="
    x86?   ( http://packages.bodhilinux.com/bodhi/pool/main/m/moksha/moksha_20150806.3-1_i386.deb -> moksha-${PV}.deb )
    AMD64? ( http://packages.bodhilinux.com/bodhi/pool/main/m/moksha/moksha_20150806.3-1_amd64.deb -> moksha-${PV}.deb)
    "

RESTRICT="mirror"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="BSD"
IUSE=""
DEPEND=">=dev-libs/efl-1.15.1
      >=dev-libs/e_dbus-1.7.10
      >=media-libs/elementary-1.5.1
      media-plugins/evas_generic_loaders
      x11-libs/xcb-util-keysyms"

RDEPEND="${DEPEND}
      	x11-libs/gtk+:2
      	x11-libs/libnotify
      	gnome-base/libgnome-keyring
      	dev-libs/nss
      	dev-libs/nspr
      	gnome-base/gconf
      	media-libs/alsa-lib
      	net-print/cups
      	sys-libs/libcap
      	x11-libs/libXtst
      	x11-libs/pango"

src_unpack() {
  unpacker_src_unpack
	mkdir -p "${S}"
	mv "${WORKDIR}/usr" "${S}"
  mv "${WORKDIR}/etc" "${S}"
}

src_install() {
	into /
	insinto /
	doins -r .
}

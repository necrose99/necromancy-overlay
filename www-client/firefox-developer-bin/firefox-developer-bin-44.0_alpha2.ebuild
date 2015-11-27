# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$


MOZ_HTTP_URI="http://archive.mozilla.org/pub/firefox/nightly/2015/11/2015-11-12-00-40-57-mozilla-aurora"

inherit eutils

DESCRIPTION="Firefox Developer Edition"
HOMEPAGE="https://www.mozilla.org/en-US/firefox/developer/"
SRC_URI="${SRC_URI}
	amd64? ( ${MOZ_HTTP_URI}/firefox-44.0a2.en-US.linux-x86_64.tar.bz2 -> ${P}-x86_64.tar.bz2 )
        x86? ( ${MOZ_HTTP_URI}/firefox-44.0a2.en-US.linux-i686.tar.bz2  -> ${P}-i686.tar.bz2 )"

LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


S="${WORKDIR}/firefox"

DEPEND="app-arch/unzip"

RDEPEND="dev-libs/atk
	>=sys-apps/dbus-0.60
	>=dev-libs/dbus-glib-0.72
	>=dev-libs/glib-2.26:2
	>=media-libs/alsa-lib-1.0.16
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf
	>=x11-libs/gtk+-2.14:2
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXt
	>=x11-libs/pango-1.22.0
	virtual/freedesktop-icon-theme
"
QA_PREBUILT="
	opt/${PN}/*.so
	opt/${PN}/firefox-bin
        opt/${PN}/firefox
	opt/${PN}/${PN}
	opt/${PN}/crashreporter
	opt/${PN}/webapprt-stub
	opt/${PN}/plugin-container
	opt/${PN}/mozilla-xremote-client
	opt/${PN}/updater
"
src_install() {
        local size sizes icon_path icon name
	sizes="16 32 48"
	icon_path="${S}/browser/chrome/icons/default"
	icon="${PN}"
	name="Mozilla Firefox"

	# Install icons and .desktop for menu entry
	for size in ${sizes}; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "${icon_path}/default${size}.png" "${icon}.png" || die
	done
	# The 128x128 icon has a different name
	insinto "/usr/share/icons/hicolor/128x128/apps"
	newins "${icon_path}/../../../icons/mozicon128.png" "${icon}.png" || die
	# Install a 48x48 icon into /usr/share/pixmaps for legacy DEs
	newicon "${S}"/browser/chrome/icons/default/default48.png ${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop
	sed -i -e "s:@NAME@:${name}:" -e "s:@ICON@:${icon}:" \
		"${ED}/usr/share/applications/${PN}.desktop" || die


	dodir /opt
	mv "${S}" "${D}/opt/${PN}"

	dodir /usr/bin
	cat <<-EOF >"${D}"/usr/bin/${PN}
	#!/bin/sh
	unset LD_PRELOAD
	LD_LIBRARY_PATH="/opt/${PN}/"
	GTK_PATH=/usr/lib/gtk-2.0/
	exec /opt/${PN}/firefox-bin "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}
}

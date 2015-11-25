# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bashnapi/bashnapi-1.1.5.ebuild,v 1.1 2013/05/12 07:15:59 mgorny Exp $

EAPI=5

inherit git-r3

DESCRIPTION="Napiprojekt.pl subtitle downloader in bash"
HOMEPAGE="https://github.com/dagon666/napi"
EGIT_REPO_URI="https://github.com/dagon666/napi"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!media-video/subotage"

src_install() {
	default # for docs

	local token='NAPI_COMMON_PATH'
	local replacement="${token}=\"/usr/lib\""

	sed -i "s|${token}=|${replacement}|" "napi.sh"
	sed -i "s|${token}=|${replacement}|" "subotage.sh"

	dobin napi.sh
	dobin subotage.sh

	dolib napi_common.sh
}

pkg_postinst() {
	elog "Optional runtime dependencies:"
	elog
	elog "   \033[1mmedia-video/mediainfo\033[0m"
	elog "or \033[1mmedia-video/mplayer\033[0m for FPS detection (for conversion)"
}

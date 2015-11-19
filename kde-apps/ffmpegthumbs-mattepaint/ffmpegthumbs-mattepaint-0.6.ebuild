# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit kde5 cmake-utils

DESCRIPTION="A Mattepaint ffmpeg thumbnailer for KF5"
HOMEPAGE="http://kde-apps.org/content/show.php/FFMpegThumbs-MattePaint?content=153902"
SRC_URI="http://kde-apps.org/CONTENT/content-files/153902-ffmpegthumbs-mattepaint.tar.gz"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="amd64 x86"
LICENSE="GPL-2"

DEPEND="
	kde-apps/dolphin
	media-video/libav
	dev-util/cmake
"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}/KF5/${PN}

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=$(kf5-config --prefix)
		-DCMAKE_BUILD_TYPE=Release
		-DKDE_INSTALL_USE_QT_SYS_PATHS=ON
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

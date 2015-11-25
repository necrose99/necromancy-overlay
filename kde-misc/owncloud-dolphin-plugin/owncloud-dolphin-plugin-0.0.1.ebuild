# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit kde4-base

DESCRIPTION="Owncloud plugin for dolphin"
HOMEPAGE="http://owncloud.org"
SRC_URI="https://build.opensuse.org/source/isv:ownCloud:devel/dolphin-plugins/owncloud.tar.gz -> owncloud-dolphin-plugin.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
        $(add_kdeapps_dep libkonq)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/owncloud"

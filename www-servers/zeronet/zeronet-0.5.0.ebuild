# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_P=ZeroNet
DESCRIPTION="Open, free and uncensorable websites using Bitcoin cryptography and BitTorrent network."
HOMEPAGE="https://zeronet.io/"
SRC_URI="https://github.com/HelloZeroNet/${MY_P}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-python/gevent-1.1.0
	>=dev-python/msgpack-0.4.4
	dev-python/pip
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}-${PV}

DOCS=( CHANGELOG.md README.md requirements.txt )

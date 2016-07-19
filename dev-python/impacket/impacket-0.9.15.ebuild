# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python Impacket extension"
HOMEPAGE="http://oss.coresecurity.com/projects/impacket.html"
MY_PN="Impacket"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz
	http://oss.coresecurity.com/repo/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~*"
IUSE=""

S="${WORKDIR}/${MY_P}"

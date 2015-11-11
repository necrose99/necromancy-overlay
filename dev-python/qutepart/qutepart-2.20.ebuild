# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION=" Code editor component for PyQt and PySide & enki-editor.org"
HOMEPAGE="https://github.com/hlamer/qutepart"
SRC_URI="https://github.com/hlamer/qutepart/archive/v${PV}.tar.gz -> qutepart-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="~app-forensics/yara-${PV}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/yara-${PV}/yara-python"

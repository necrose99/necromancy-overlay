# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION=" Code editor component for PyQt and PySide & enki-editor.org"
HOMEPAGE="https://github.com/hlamer/qutepart"
SRC_URI="https://github.com/hlamer/qutepart/archive/v${PV}.tar.gz -> qutepart-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libpcre
|| ( dev-python/PyQt  dev-python/PyQt4 dev-python/PyQt5 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/qutepart-${PV}/qutepart"
#python setup.py install --include-dir=../pcre-8.37/build --lib-dir=../pcre-8.37/build/Release

}
python_compile() {
	# https://code.google.com/p/editra/issues/detail?id=481
	distutils-r1_python_compile --include-dir=../pcre-8.37/build --lib-dir=../pcre-8.37/build/Release
}

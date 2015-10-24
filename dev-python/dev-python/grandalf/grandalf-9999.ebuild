# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1 git-r3

EGIT_REPO_URI="git://github.com/bdcht/${PN}.git"

DESCRIPTION="Grandalf is a python package made for experimentations with graphs and drawing algorithms"
HOMEPAGE="https://github.com/bdcht/grandalf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-python/ply
		dev-python/numpy"
RDEPEND="${DEPEND}"

python_install_all() {
        local DOCS=( README.rst )
        use doc && local DOCS=( README.rst doc/hgd.pdf )
        distutils-r1_python_install_all
}

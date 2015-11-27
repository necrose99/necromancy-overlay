# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1 mercurial

EHG_REPO_URI="https://${PN}.googlecode.com/hg/"
EHG_PROJECT="${PN}"

DESCRIPTION="Miasm is a a free and open source reverse engineering framework"
HOMEPAGE="https://code.google.com/p/miasm/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="dev-python/grandalf
		dev-lang/tcc
		dev-python/ply
		dev-python/numpy
		dev-python/virtualenv
		dev-python/PyQt4
		dev-python/elfesteem"
RDEPEND="${DEPEND}"

python_install_all() {
        local DOCS=( README.txt )
        use doc && local DOCS=( README.txt doc/slides.pdf )
		if use examples; then
			insinto /usr/share/doc/${P}
			doins "${S}"/example/*
		fi
        distutils-r1_python_install_all
}

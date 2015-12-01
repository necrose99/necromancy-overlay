# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7,2_*} pypy2_0)

inherit distutils-r1 git-r3 eutils python-single-r1.eclass

USE="doc" #Documentaion IS recomended. However Alow Users to kill if not wanted. 

EGIT_REPO_URI="https://github.com/USArmyResearchLab/Dshell.git"
EGIT_BRANCH="master"
EGIT_CHECKOUT_DIR=${WORKDIR}/${PN}

DESCRIPTION="Dshell is a network modular forensic analysis framework From USArmyResearchLab"
HOMEPAGE="https://github.com/USArmyResearchLab/Dshell"
SRC_URI=""
LICENSE="MIT"
SLOT="0"

DEPEND="dev-lang/python/python-2.*
	dev-python/pygeoip
	dev-python/ipy
	dev-python/dpkt
	dev-python/pypcap
	dev-python/pycrypto"
RDEPEND="${DEPEND}
	doc? ( dev-python/epydoc[$(python_gen_usedep 'python2*')] )"

S="${WORKDIR}/${PN}/"

src_unpack() {
git-r3_src_unpack
}
src_install() {
	cd ${WORKDIR}/${PN}/
	emake all
}

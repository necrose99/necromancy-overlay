# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} ) #pypy2_0 ie python 2.x compat to be tested. >=python-2.x <=python-3.x not yet supported.

inherit git-r3 eutils python-single-r1
IUSE="+onbydefault +doc"
USE="doc" #Documentaion IS recomended. However Alow Users to kill if not wanted. 

EGIT_REPO_URI="https://github.com/USArmyResearchLab/Dshell.git"
EGIT_BRANCH="master"
EGIT_DIR="${WORKDIR}/${PN}/"
EGIT_SOURCEDIR=""${WORKDIR}/${PN}/" git-r3_src_unpack

DESCRIPTION="Dshell is a network modular forensic analysis framework From USArmyResearchLab"
HOMEPAGE="https://github.com/USArmyResearchLab/Dshell"
SRC_URI=""
LICENSE="MIT"
SLOT="0"

DEPEND="dev-python/pygeoip
	dev-python/ipy
	dev-python/dpkt
	dev-python/pypcap
	dev-python/pycrypto"
RDEPEND="${DEPEND}
	doc? ( dev-python/epydoc )" 
	#doc? ( dev-python/epydoc[$(python_gen_usedep 'python2*')] )" ? error. for now....simplify

S="${WORKDIR}/${PN}/"

src_install() {
	cd "${S}"
	emake 
}
# havent forked emake into emake a+b then emake docs ondep yet as well, project newish so docs are in short supply. 

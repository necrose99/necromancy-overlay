# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ necrose99

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 git-r3

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="https://github.com/USArmyResearchLab/Dshell.git"
	EGIT_BRANCH="master"
	EGIT_CHECKOUT_DIR="${WORKDIR}/refpolicy"

	inherit git-r3

	KEYWORDS=""
else
	SRC_URI="https://github.com/USArmyResearchLab/Dshell/archive/v${PV}.tar.gz -> dhell-${PV}.tar.gz""
	KEYWORDS="~amd64 ~x86"
fi


DESCRIPTION="Dshell is a network forensic analysis framework"
HOMEPAGE="https://github.com/USArmyResearchLab/Dshell"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/python/python-2.7*
 dev-python/pygeoip
 dev-python/ipy
 dev-python/pypcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}/${PV}"

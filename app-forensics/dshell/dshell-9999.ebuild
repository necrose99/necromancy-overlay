# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ necrose99

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 git-r3
EAPI=5

EGIT_REPO_URI="https://github.com/USArmyResearchLab/Dshell.git"

DESCRIPTION="Magnificent app which corrects your previous console command,'fuck' will try to fix console command, "
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

S="${WORKDIR}/dshell"
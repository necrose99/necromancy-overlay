# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ necrose99

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Magnificent app which corrects your previous console command,'fuck' will try to fix console command, "
HOMEPAGE="https://github.com/nvbn/thefuck"
SRC_URI="https://github.com/nvbn/thefuck/archive/v${PV}.tar.gz -> thefuck-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/thefuck-${PV}/thefuck"
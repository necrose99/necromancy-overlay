# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit python-any-r1 git-3
PYTHON_COMPAT=( python2_7 )


DESCRIPTION="Veil-Catapult is a payload delivery tool that integrates with Veil-Evasion"
GO_PN="github.com/hashicorp/${PN}"
HOMEPAGE="https://www.veil-framework.com/"
EGIT_REPO_URI="https://github.com/Veil-Framework/Veil-Ordnance.git"
LICENSE="MPL-2.0"
SLOT="0"
IUSE="test"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/impacket "
RDEPEND="${DEPEND}"

S="${WORKDIR}/veil-catapult-${PV}/veil-catapult"

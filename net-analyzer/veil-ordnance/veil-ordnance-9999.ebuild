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

DEPEND=
#"#-${PV}"
RDEPEND="${DEPEND}"

${S}="${WORKDIR}/veil-ordnance"
src_unpack()	# This function unpacks our files
{ git-r3_src_unpack
}
src_install()
{
	mkdir -p ${S}/opt/bin/veil-ordnance		# D is like a virtual / where we install our stuff, before emerge 
					# merge it with the real /
	cp unmask ${S}/opt/bin/veil-ordnance	# now we simply copy "unmask" to our target dir
       chmod +x ${S}/opt/bin/veil-ordnance/unmask   # and make our script executable
		dodoc doc /usr/share/doc/${P}
		mkdir -p ${S}/usr/share/doc/${P}
		cp ${FILESDIR}/README.md ${D}/usr/share/doc/${P}/
	fi
}

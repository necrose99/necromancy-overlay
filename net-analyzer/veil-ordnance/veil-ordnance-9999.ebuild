# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="Veil-Ordnance is a tool designed to quickly generate MSF stager shellcode integrates with Veil-Evasion"
HOMEPAGE="https://www.veil-framework.com/"
EGIT_REPO_URI="https://github.com/Veil-Framework/Veil-Ordnance.git"
LICENSE="MPL-2.0"
SLOT="0"
IUSE="test"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tools"

DEPEND="net-analyzer/veil-evasion"
RDEPEND=">=dev-python/pycrypto-2.3
	dev-python/symmetricjsonrpc
	dev-python/pefile
	dev-python/capstone-python
	tools? (
		dev-lang/go
		app-emulation/wine
		net-analyzer/metasploit )
	"

${S}="${WORKDIR}/veil-ordnance"
src_unpack()	# This function unpacks our files
{ git-r3_src_unpack
}

src_install() {
	rm -r config/
	rm -r setup/

	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/Veil-Catapult.py


	dosym /usr/$(get_libdir)/veil-evasion/Ordnance/Veil-Ordnance.py /usr/bin/veil-ordnance.py
}


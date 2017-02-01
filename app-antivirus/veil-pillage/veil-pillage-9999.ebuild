# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit python-any-r1 git-3
PYTHON_COMPAT=( python2_7 )


DESCRIPTION="Veil-Catapult is a payload delivery tool that integrates with Veil-Evasion"
HOMEPAGE="https://github.com/Veil-Framework/Veil-Pillage"
EGIT_REPO_URI="https://github.com/Veil-Framework/Veil-Pillage.git"
LICENSE="MPL-2.0"
SLOT="0"
IUSE="test"

LICENSE="gpl3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-analyzer/veil-evasion"
RDEPEND=">=dev-python/pycrypto-2.3
	dev-python/symmetricjsonrpc
	dev-python/pefile
	dev-python/capstone-python
        app-emulation/wine
	net-analyzer/metasploit 
	"
src_unpack()	
# This function unpacks our files
{ 
	git-r3_src_unpack
}

S="${WORKDIR}/veil-catapult-${PV}/veil-catapult"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tools"


# FIXME:
#  pyinstaller
#  mingw-w64 monodoc-browser monodevelop mono-mcs unzip ruby wget git \
#  ca-certificates ttf-mscorefonts-installer

S="${WORKDIR}/Veil-Catapult-${PV}"

src_install() {
	rm -r config/
	rm -r setup/

	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	python_fix_shebang "${ED}"/usr/$(get_libdir)/veil-evasion/${PN}/Veil-Catapult.py


	dosym /usr/$(get_libdir)/veil-evasion/catapult/Veil-Catapult.py /usr/bin/veil-catapult
}


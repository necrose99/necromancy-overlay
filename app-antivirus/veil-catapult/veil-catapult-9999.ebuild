# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit python-any-r1 git-3
PYTHON_COMPAT=( python2_7 )


DESCRIPTION="Veil-Catapult is a payload delivery tool that integrates with Veil-Evasion, A tool to bypass common anti-virus solutions"
HOMEPAGE="https://github.com/Veil-Framework/Veil-Evasion""
HOMEPAGE="https://www.veil-framework.com/"
EGIT_REPO_URI="https://github.com/Veil-Framework/Veil-Catapult.git"
LICENSE="MPL-2.0"
SLOT="0"
IUSE="test"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${RDEPEND}"
RDEPEND="net-analyzer/veil-evasion"

S="${WORKDIR}/Veil-Catapult-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="tools"



src_prepare() {
	#+os.path.expanduser(settings.PYINSTALLER_PATH + '/pyinstaller.py')+
	# os.path.expanduser(settings.PYINSTALLER_PATH + '/pyinstaller.py')
	#sed -i "s|os.path.expanduser(settings.PYINSTALLER_PATH + '/pyinstaller.py')|'/usr/bin/pyinstall'|g" modules/common/supportfiles.py || die "sed failed"
        ## uses APT GET , no need. 
	rm /${WORKDIR}/Veil-Catapult-${PV}/setup.sh
}

src_install() {
	rm -r config/
	rm -r setup/

	dodir /usr/$(get_libdir)/veil-evasion/${PN}/
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/Veil-Catapult.py



	dosym /usr/$(get_libdir)/veil-evasion/veil-catapult/Veil-Catapult.py /usr/bin/Veil-catapult
}

pkg_postinst(){
	einfo "you will need to setup a wine env for pyinstaller , veil prefix recomended."
	einfo "wine msiexec /i python-2.7.12.msi"
}



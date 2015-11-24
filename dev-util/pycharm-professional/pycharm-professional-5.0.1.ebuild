# Copyright open-overlay 2015 by Alex

EAPI=5

inherit eutils versionator
MY_PN=${PN/-professional/} 
MY_PV="$(get_version_component_range 1-3)"
MY_STRING_VERSION="$(get_version_component_range 4-5)"
DESCRIPTION="PyCharm"
HOMEPAGE="http://www.jetbrains.com/pycharm/"
SRC_URI="http://download-cf.jetbrains.com/python/${PN}-${MY_PV}.tar.gz"

LICENSE="Apache-2.0 BSD CDDL MIT-with-advertising"
KEYWORDS="x86 amd64"

DEPEND=">=virtual/jre-1.6
        dev-python/pip"

RDEPEND="${DEPEND}"

SLOT="0"

S="${WORKDIR}/${PN}-${MY_PV}"

QA_PRESTRIPPED="opt/pycharm-community/lib/libpty/linux/x86_64/libpty.so
                opt/pycharm-community/lib/libpty/linux/x86/libpty.so"

#pkg_postinst() {
#               echo 
#               echo "This is EAP Pycharm 5"
#               echo        
#}
src_install()
{	
	# copy files
  dodir /opt/${PN}
	insinto /opt/${PN}
	doins -r *
fperms a+x /opt/${PN}/bin/{pycharm.sh,fsnotifier{,64},inspect.sh}

	dosym /opt/${PN}/bin/pycharm.sh /usr/bin/${PN}
	newicon "bin/${MY_PN}.png" ${PN}.png
	make_desktop_entry ${PN} "${PN}" "${PN}"	
}




# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils versionator rpm

MY_PN="centrify-suite"
MY_PV=$(replace_version_separator 2 '-')
MY_P="${MY_PN}-${MY_PV}"

SRC_URI="
    x86?   ( http://edge.centrify.com/products/opensource/samba-4.5.9/centrify-samba-4.5.9-rhel3-i386.tgz )
    AMD64? ( http://edge.centrify.com/products/opensource/samba-4.5.9/centrify-samba-4.5.9-rhel3-x86_64.tgz )"
DESCRIPTION="centrify-suite "
HOMEPAGE="http://www.centrify.com/"
#EULA="https://www.centrify.com/eula/"

LICENSE="freeware,eula"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"

# Need to test if the file can be unpacked with rpmoffset and cpio
# If it can't then set:

#DEPEND="app-arch/rpm"

# To force the use of rpmoffset and cpio instead of rpm2cpio from
# app-arch/rpm, then set the following:

#USE_RPMOFFSET_ONLY=1
RDEPEND="app-eselect/eselect-opencl
	dev-cpp/tbb
	sys-process/numactl
	tools? (
		sys-devel/llvm
		>=virtual/jre-1.6
	)"
DEPEND=""

RESTRICT="mirror"
QA_EXECSTACK="${INTEL_CL/\//}libcpu_device.so
	${INTEL_CL/\//}libOclCpuBackEnd.so
	${INTEL_CL/\//}libtask_executor.so"
QA_PREBUILT="${INTEL_CL}*"

S=${WORKDIR}


src_unpack() {
	default
	rpm_unpack ./${MY_P}.rpm
}

src_prepare() {
	# Remove unnecessary and bundled stuff
	rm -rf ${INTEL_CL}/{docs,version.txt,llc}
	rm -f ${INTEL_CL}/libboost*.so
	rm -f ${INTEL_CL}/libtbb*
	if ! use tools; then
		rm -rf usr/bin
		rm -f ${INTEL_CL}/{ioc64,ioc.jar}
		rm -f ${INTEL_CL}/libboost*
	fi
}

src_install() {
	doins -r etc

	insinto ${INTEL_CL}
	doins -r usr/include

	insopts -m 755
	newins usr/$(get_libdir)/libOpenCL.so libOpenCL.so.1
	dosym libOpenCL.so.1 ${INTEL_CL}/libOpenCL.so

	doins ${INTEL_CL}/*
}

pkg_postinst() {
	eselect opencl set --use-old intel
}

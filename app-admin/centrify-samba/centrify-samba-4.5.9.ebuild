# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils versionator rpm

MY_PN="centrify-suite"
MY_PV=$(replace_version_separator 2 '-')
MY_P="${MY_PN}-${MY_PV}"

http://edge.centrify.com/products/centrify-suite/2015-update-1/installers/centrify-suite-2015.1-rhel4-i386.tgz
http://edge.centrify.com/products/opensource/samba-4.5.9/centrify-samba-4.5.9-rhel3-i386.tgz
http://edge.centrify.com/products/opensource/kerberos-5.1.0/centrify-krb5-5.1.0-rhel3-i386.tgz

http://edge.centrify.com/products/centrify-suite/2015-update-1/installers/centrify-suite-2015.1-rhel4-x86_64.tgz
http://edge.centrify.com/products/opensource/samba-4.5.9/centrify-samba-4.5.9-rhel3-x86_64.tgz
http://edge.centrify.com/products/opensource/kerberos-5.1.0/centrify-krb5-5.1.0-rhel3-x86_64.tgz

SRC_URI="
    x86?   ( https://update.gitter.im/linux32/latest )
    AMD64? ( https://update.gitter.im/linux64/latest )"
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

S=${WORKDIR}/fetchmail-$(get_version_component_range 1-3)

src_unpack () {
    rpm_src_unpack ${A}
    cd "${S}"
    EPATCH_SOURCE="${WORKDIR}" EPATCH_SUFFIX="patch" \
        EPATCH_FORCE="yes" epatch
}

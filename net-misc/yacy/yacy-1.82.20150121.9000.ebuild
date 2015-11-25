# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=5

inherit eutils versionator user

MAJOR_PV="$(get_version_component_range 1-2)"
REL_PV="$(get_version_component_range 3)"
SVN_PV="$(get_version_component_range 4)"

DESCRIPTION="p2p based distributed web-search engine - latest stable binary"
HOMEPAGE="http://www.yacy.net/"
SRC_URI="http://yacy.net/release/yacy_v${MAJOR_PV}_${REL_PV}_${SVN_PV}.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND=">=virtual/jdk-1.5.0"
RESTRICT="mirror"
LICENSE="GPL-2"
IUSE=""

S="${WORKDIR}/yacy"

src_install() {
        dodir /opt
        mv "${S}" "${D}/opt/${PN}"
        chown -R ${PN}:${PN} "${D}/opt/${PN}"

	dodir /var/log/yacy
	chown yacy:yacy "${D}/var/log/yacy"
	sed -i "s:DATA/LOG/:/var/log/yacy/:g" "${D}/opt/yacy/defaults/yacy.logging"

	exeinto /etc/init.d
	newexe "${FILESDIR}/yacy.rc" yacy
	insinto /etc/conf.d
	newins "${FILESDIR}/yacy.confd" yacy
}

pkg_setup() {
        enewgroup ${PN}
        enewuser ${PN} -1 /bin/bash /opt/${PN} ${PN}
}

pkg_postinst() {
	einfo "yacy.logging will write logfiles into /var/log/yacy/"
	einfo "To setup YaCy, open http://localhost:8090 in your browser."
}


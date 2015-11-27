# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit multilib unpacker

MY_PV=${PV/_p/-}
MY_PN=${PN%%-bin-debian}

DESCRIPTION="gitter deeveloper Instant measenger  binary (intergrates to github & IRC with MD)"
HOMEPAGE="https://gitter.im/apps"
SRC_URI="
    x86?   ( https://update.gitter.im/linux32/latest )
    AMD64? ( https://update.gitter.im/linux64/latest )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="Doc"

DEPEND="app-arch/deb2targz"
RDEPEND="net-libs/nodejs"
QA_PREBUILT="*"
S=${WORKDIR}

src_unpack() {
        unpack_deb ${A}
        }

src_install() {
	cp -a * "${D}" || die
        dodir /opt/${PN}/linux64"
        insinto /opt/${PN}/linux64
	doins -r *
	fperms +x /opt/gitter/linux64
	dobin "${FILESDIR}/opt/${PN}/linux64"
	dosym /opt/${PN}/linux64/${PN} /usr/local/bin/${PN}
	make_desktop_entry gitter Gitter \
		"/opt/gitter/linux64logo.png" \
		Network
	distutils-r1_src_install
	use doc && dodoc -r /usr/share/doc/gitter/*	
	echo sid > "${D}"/etc/debian_version || die
}

}
pkg_postinst() {
	elog "Gitter Debian is installed ,NOTE Gitter is self Updating if Enabled"
}

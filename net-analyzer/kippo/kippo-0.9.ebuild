# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils python-r1 user

DESCRIPTION="SSH honeypot, log brute force attacks and shell interaction performed by the attacker."
HOMEPAGE="https://github.com/desaster/kippo"
SRC_URI="https://github.com/desaster/${PN}/archive/v${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/twisted-core
	dev-python/twisted-conch
	dev-python/twisted-web
	net-zope/zope-interface
	dev-python/pycrypto
	dev-python/pyasn1"
RDEPEND="${DEPEND}"

KIPPO_INSTALL_DIR="/opt/kippo"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_install() {
	insinto ${KIPPO_INSTALL_DIR}
	dodir ${KIPPO_INSTALL_DIR}
	diropts -m0770
	doins -r "${S}"/*
	chmod 660 "${D}/${KIPPO_INSTALL_DIR}/kippo.cfg.dist"
	dodoc doc/README doc/sql/mysql.sql
	rm -rf "${D}/opt/${PN}/doc"
	exeinto ${KIPPO_INSTALL_DIR}
	doexe start.sh
	fowners -R "${PN}:${PN}" "${KIPPO_INSTALL_DIR}/"
}

pkg_postinst() {
	ewarn "IMPORTANT:"
	ewarn "DONT run kippo as root add your user to group kippo"
}

pkg_postrm() {
	python_mod_cleanup /opt/${PN}
}

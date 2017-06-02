# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit systemd

HOMEPAGE="https://www.zerotier.com/"
DESCRIPTION="A software-based managed Ethernet switch for planet Earth."
SRC_URI="https://github.com/zerotier/ZeroTierOne/archive/${PV}.tar.gz -> zerotier-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/ZeroTierOne-${PV}"

RDEPEND="net-libs/http-parser
	net-libs/miniupnpc
	net-libs/libnatpmp
	dev-libs/json-glib"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.9.3"

QA_PRESTRIPPED="/usr/sbin/zerotier-one"

src_compile() {
	emake one
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README.md AUTHORS.md
	doinitd "${FILESDIR}"/zerotier-one
	systemd_dounit "${S}"/debian/zerotier-one.service
	doman "${S}/doc/zerotier-"{cli.1,idtool.1,one.8}
}

pkg_postinst() {
	elog "If you previously had ZeroTier-One installed from their generic"
	elog "script, you may need to rejoin your network(s) with"
	elog ""
	elog "\"zerotier-cli join <network>\""
	elog ""
	elog "and then re-authorise the host on the web interface."
}

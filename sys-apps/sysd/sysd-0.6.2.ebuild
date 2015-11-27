# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils systemd

DESCRIPTION="The daemon who supplies firsthand system data"
HOMEPAGE="https://github.com/hacking-thursday/sysd"
SRC_URI="https://github.com/hacking-thursday/${PN}/releases/download/v${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	dev-lang/go
	"
RDEPEND="${DEPEND}"

src_install() {
	emake \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		DESTDIR="${D}" \
		install

	newinitd "${FILESDIR}"/sysd.init sysd
	systemd_dounit "${FILESDIR}/sysd.service"
}

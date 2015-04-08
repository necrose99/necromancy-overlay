# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Conducts Internet measurement tasks to large numbers of IPv4 and IPv6 addresses, in parallel, to fill a specified packets-per-second rate."
HOMEPAGE="http://www.caida.org/tools/measurement/scamper/"
SRC_URI="http://www.caida.org/tools/measurement/scamper/code/scamper-cvs-20140530.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="privsep debug"
EAPI=2

DEPEND=""
RDEPEND="${DEPEND}"

inherit eutils

S="${WORKDIR}/scamper-cvs-20110217"

src_configure() {
	econf \
		$(use_enable privsep privsep) \
		$(use_enable debug debug-file) || die
}

src_install() {
	emake install DESTDIR="${D}" || die
}

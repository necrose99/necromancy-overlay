# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )
inherit python-r1

DESCRIPTION="A Honeypot for the SSH Service"
HOMEPAGE="http://kojoney.sourceforge.net/ http://code.google.com/p/kojoney-patch/"
SRC_URI="http://kojoney-patch.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# dev-python/pydns, dev-python/twisted* and dev-python/xmpppy should be
# converted to python-r1
# possible further dependencies are:
# dev-python/mysql-python
# dev-python/pydns
# dev-python/psycopg
# dev-python/xmpppy
# net-analyzer/p0f
#	net-misc/openssh

RDEPEND=">=dev-libs/gmp-5.0.5
	dev-libs/geoip[city]
	dev-lang/perl
	dev-perl/Geography-Countries
	dev-perl/Geo-IP
	>=dev-python/python-exec-0.3.1
	>=dev-perl/IP-Country-2.270
	>=dev-python/pyasn1-0.1.3[${PYTHON_USEDEP}]
	>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-0.7.9[${PYTHON_USEDEP}]
	>=dev-python/twisted-11.0.0
	>=dev-python/twisted-conch-11.0.0
	>=net-zope/zope-interface-3.8.0[${PYTHON_USEDEP}]
	virtual/perl-Digest-SHA
	${PYTHON_DEPS}
	"
S="${WORKDIR}"/${PN}

PATCHES=( "${FILESDIR}"/${P}-space.patch )

src_install() {
	local python_moduleroot
	python_foreach_impl python_domodule coret*.py p0f.py

	local python_scriptroot
	python_foreach_impl python_doscript kojoney.py jabberbot.py

	dobin reports/{kip2ASN,kip2country,kip2country.old,kojhumans,kojhumans.old,kojreport,kojreport-filter,kojsession}
	dosym /usr/bin/kojoney.py /usr/bin/kojoneyd

	dodir /etc/${PN}
	insinto /etc/${PN}
	doins fake_users{,.old}

	doman docs/man/{kip2country,kojhumans,kojreport-filter,kojreport}.1
	dohtml -r docs/html
	doinitd init.d/kojoney

	keepdir /var/log/kojoney
}

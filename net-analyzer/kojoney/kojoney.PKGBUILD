# This file is part of BlackArch Linux ( http://blackarch.org ).
# See COPYING for license details.

pkgname='kippo'
pkgver='0.9'
pkgrel=1
pkgdesc='A medium interaction SSH honeypot designed to log brute force attacks and most importantly, the entire shell interaction by the attacker.'
groups=('blackarch' 'blackarch-honeypot')
arch=('any')
url='https://github.com/desaster/kippo'
license=('GPL')
depends=('python2' 'twisted' 'python2-crypto' 'python2-pyasn1')
source=("https://github.com/desaster/kippo/archive/v${pkgver}.tar.gz")
sha1sums=('fa7463598cc14d8e506da69624dca01f9bddad4c')

package() {
  cd "$srcdir/kippo-$pkgver"

  mkdir -p "$pkgdir/usr/share/kippo/"

  cp -r * "$pkgdir/usr/share/kippo/"

  cd "$pkgdir/usr/share/kippo"

  ln -sf kippo.cfg.dist kippo.cfg
}
# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )
inherit python-r1 git-r3

DESCRIPTION="A Honeypot for the SSH Service log brute force attacks by the attacker"
HOMEPAGE="https://github.com/madirish/kojoney2"
if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="EGIT_REPO_URI="https://github.com/madirish/kojoney2.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/madirish/${PN}/archive/v${PV}.zip" -> ${P}.tar.gz"
	inherit versionator
	S="${WORKDIR}"/${PN}-${PN}_$(replace_all_version_separators _)
	KEYWORDS="~amd64 ~x86"
fi

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
